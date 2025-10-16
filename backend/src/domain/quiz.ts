export interface Quiz {
  id: string;
  category: 'basic' | 'intermediate' | 'advanced' | 'lightning';
  difficulty: 'easy' | 'medium' | 'hard';
  question: string;
  answers: string[];
  correctAnswer: number;
  explanation: string;
  reward: number;
  createdAt: Date;
}

export class QuizEntity implements Quiz {
  constructor(
    public id: string,
    public category: 'basic' | 'intermediate' | 'advanced' | 'lightning',
    public difficulty: 'easy' | 'medium' | 'hard',
    public question: string,
    public answers: string[],
    public correctAnswer: number,
    public explanation: string,
    public reward: number,
    public createdAt: Date
  ) {}

  validateAnswer(answerIndex: number): boolean {
    return answerIndex === this.correctAnswer;
  }

  calculateReward(streak: number): number {
    const baseReward = this.reward;
    const streakBonus = Math.floor(streak / 7) * 5; // +5 sats por cada semana de racha
    return baseReward + streakBonus;
  }
}