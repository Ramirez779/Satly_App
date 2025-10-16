import { Router } from 'express';
import { QuizController } from '../controllers/quiz.controller.js';
import { authMiddleware } from '../../infrastructure/auth/jwt.js';

const router = Router();
const quizController = new QuizController();

router.use(authMiddleware);

router.get('/daily', quizController.getDailyQuiz.bind(quizController));
router.post('/submit', quizController.submitAnswer.bind(quizController));

export { router as quizRoutes };