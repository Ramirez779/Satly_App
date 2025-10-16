import { createClient } from '@supabase/supabase-js';
import { env } from '../../config/env.js';

export const supabase = createClient(
  env.SUPABASE_URL,
  env.SUPABASE_ANON_KEY
);

// Tipos para la base de datos
export interface DatabaseUser {
  id: string;
  email: string;
  name: string;
  level: number;
  total_sats: number;
  daily_limit: number;
  streak: number;
  quizzes_completed: number;
  created_at: string;
  updated_at: string;
}

export interface DatabaseQuiz {
  id: string;
  category: 'basic' | 'intermediate' | 'advanced' | 'lightning';
  difficulty: 'easy' | 'medium' | 'hard';
  question: string;
  answers: string[];
  correct_answer: number;
  explanation: string;
  reward: number;
  created_at: string;
}