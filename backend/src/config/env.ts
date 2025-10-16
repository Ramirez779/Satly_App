import { z } from 'zod';

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'production', 'test']).default('development'),
  PORT: z.string().transform(Number).default('3000'),
  
  // Supabase
  SUPABASE_URL: z.string().url(),
  SUPABASE_ANON_KEY: z.string(),
  
  // LNBits
  LNBITS_URL: z.string().url(),
  LNBITS_ADMIN_KEY: z.string(),
  
  // JWT
  JWT_SECRET: z.string().min(32),
  
  // App
  DAILY_SATS_LIMIT: z.string().transform(Number).default('50'),
});

export const env = envSchema.parse(process.env);
export type EnvConfig = z.infer<typeof envSchema>;