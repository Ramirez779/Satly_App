import { QuizEntity, Quiz } from '../domain/Quiz.js';
import { UserEntity } from '../domain/User.js';
import { supabase, DatabaseQuiz } from '../infrastructure/database/supabase.js';
import { LNBitsService } from '../infrastructure/lightning/lnbits.service.js';

export interface QuizResult {
  isCorrect: boolean;
  reward?: number;
  explanation: string;
  userLevel: number;
  totalSats: number;
  dailyLimitRemaining: number;
  paymentHash?: string;
}

export class QuizService {
  private lnbitsService: LNBitsService;

  constructor() {
    this.lnbitsService = new LNBitsService();
  }

  async getRandomQuiz(userLevel: number): Promise<QuizEntity> {
    // Obtener quiz aleatorio basado en el nivel del usuario
    const { data, error } = await supabase
      .from('quizzes')
      .select('*')
      .gte('reward', userLevel * 10) // Quizzes con recompensas apropiadas
      .limit(1)
      .order('random()', { ascending: true });

    if (error || !data || data.length === 0) {
      throw new Error('No quizzes available');
    }

    return this.mapToEntity(data[0]);
  }

  async submitQuiz(
    user: UserEntity, 
    quizId: string, 
    answerIndex: number
  ): Promise<QuizResult> {
    // Obtener el quiz
    const { data, error } = await supabase
      .from('quizzes')
      .select('*')
      .eq('id', quizId)
      .single();

    if (error || !data) {
      throw new Error('Quiz not found');
    }

    const quiz = this.mapToEntity(data);
    const isCorrect = quiz.validateAnswer(answerIndex);

    if (isCorrect && user.canReceiveReward(quiz.reward)) {
      const rewardAmount = quiz.calculateReward(user.streak);
      
      try {
        // Enviar pago via Lightning
        const payment = await this.lnbitsService.sendPayment(
          rewardAmount,
          `EduSats Reward - User: ${user.id}`
        );

        // Actualizar usuario
        user.addReward(rewardAmount);
        await this.updateUser(user);

        // Registrar transacción
        await this.recordTransaction(user.id, rewardAmount, payment.payment_hash);

        return {
          isCorrect: true,
          reward: rewardAmount,
          explanation: quiz.explanation,
          userLevel: user.level,
          totalSats: user.totalSats,
          dailyLimitRemaining: user.dailyLimit,
          paymentHash: payment.payment_hash
        };

      } catch (paymentError) {
        throw new Error('Failed to process reward payment');
      }
    }

    return {
      isCorrect: false,
      explanation: quiz.explanation,
      userLevel: user.level,
      totalSats: user.totalSats,
      dailyLimitRemaining: user.dailyLimit
    };
  }

  private async updateUser(user: UserEntity): Promise<void> {
    const { error } = await supabase
      .from('users')
      .update({
        level: user.level,
        total_sats: user.totalSats,
        daily_limit: user.dailyLimit,
        streak: user.streak,
        quizzes_completed: user.quizzesCompleted,
        updated_at: user.updatedAt.toISOString()
      })
      .eq('id', user.id);

    if (error) {
      throw new Error(`Failed to update user: ${error.message}`);
    }
  }

  private async recordTransaction(
    userId: string, 
    amount: number, 
    paymentHash: string
  ): Promise<void> {
    const { error } = await supabase
      .from('transactions')
      .insert({
        user_id: userId,
        amount: amount,
        payment_hash: paymentHash,
        status: 'completed'
      });

    if (error) {
      console.error('Failed to record transaction:', error);
    }
  }

  private mapToEntity(data: DatabaseQuiz): QuizEntity {
    return new QuizEntity(
      data.id,
      data.category,
      data.difficulty,
      data.question,
      data.answers,
      data.correct_answer,
      data.explanation,
      data.reward,
      new Date(data.created_at)
    );
  }
}