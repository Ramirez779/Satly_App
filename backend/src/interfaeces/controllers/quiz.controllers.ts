import { Request, Response } from 'express';
import { QuizService } from '../../application/QuizService.js';
import { UserService } from '../../application/UserService.js';

export class QuizController {
  private quizService: QuizService;
  private userService: UserService;

  constructor() {
    this.quizService = new QuizService();
    this.userService = new UserService();
  }

  async getDailyQuiz(req: Request, res: Response) {
    try {
      const userId = (req as any).user.userId;
      
      const user = await this.userService.getUserById(userId);
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }

      const quiz = await this.quizService.getRandomQuiz(user.level);

      res.json({
        success: true,
        data: {
          quiz: {
            id: quiz.id,
            category: quiz.category,
            difficulty: quiz.difficulty,
            question: quiz.question,
            answers: quiz.answers,
            reward: quiz.reward
          }
        }
      });

    } catch (error: any) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }

  async submitAnswer(req: Request, res: Response) {
    try {
      const userId = (req as any).user.userId;
      const { quizId, answerIndex } = req.body;

      if (typeof answerIndex !== 'number' || answerIndex < 0 || answerIndex > 3) {
        return res.status(400).json({ error: 'Invalid answer index' });
      }

      const user = await this.userService.getUserById(userId);
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }

      const result = await this.quizService.submitQuiz(user, quizId, answerIndex);

      res.json({
        success: true,
        data: result
      });

    } catch (error: any) {
      res.status(400).json({
        success: false,
        error: error.message
      });
    }
  }
}