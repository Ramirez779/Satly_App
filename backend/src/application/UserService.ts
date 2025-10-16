import { UserEntity, User } from '../domain/User.js';
import { supabase, DatabaseUser } from '../infrastructure/database/supabase.js';

export class UserService {
  async createUser(email: string, name: string): Promise<UserEntity> {
    const user = UserEntity.create(email, name);
    
    const { error } = await supabase
      .from('users')
      .insert({
        id: user.id,
        email: user.email,
        name: user.name,
        level: user.level,
        total_sats: user.totalSats,
        daily_limit: user.dailyLimit,
        streak: user.streak,
        quizzes_completed: user.quizzesCompleted,
        created_at: user.createdAt.toISOString(),
        updated_at: user.updatedAt.toISOString()
      });

    if (error) {
      throw new Error(`Failed to create user: ${error.message}`);
    }

    return user;
  }

  async getUserById(id: string): Promise<UserEntity | null> {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', id)
      .single();

    if (error || !data) return null;

    return this.mapToEntity(data);
  }

  async getUserByEmail(email: string): Promise<UserEntity | null> {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('email', email)
      .single();

    if (error || !data) return null;

    return this.mapToEntity(data);
  }

  async updateUser(user: UserEntity): Promise<void> {
    const { error } = await supabase
      .from('users')
      .update({
        name: user.name,
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

  private mapToEntity(data: DatabaseUser): UserEntity {
    return new UserEntity(
      data.id,
      data.email,
      data.name,
      data.level,
      data.total_sats,
      data.daily_limit,
      data.streak,
      data.quizzes_completed,
      new Date(data.created_at),
      new Date(data.updated_at)
    );
  }
}