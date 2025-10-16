export interface User {
  id: string;
  email: string;
  name: string;
  level: number;
  totalSats: number;
  dailyLimit: number;
  streak: number;
  quizzesCompleted: number;
  createdAt: Date;
  updatedAt: Date;
}

export class UserEntity implements User {
  constructor(
    public id: string,
    public email: string,
    public name: string,
    public level: number,
    public totalSats: number,
    public dailyLimit: number,
    public streak: number,
    public quizzesCompleted: number,
    public createdAt: Date,
    public updatedAt: Date
  ) {}

  static create(email: string, name: string): UserEntity {
    const now = new Date();
    return new UserEntity(
      crypto.randomUUID(),
      email,
      name,
      1, // level
      0, // totalSats
      50, // dailyLimit
      0, // streak
      0, // quizzesCompleted
      now,
      now
    );
  }

  canReceiveReward(amount: number): boolean {
    return this.dailyLimit >= amount;
  }

  addReward(amount: number): void {
    this.totalSats += amount;
    this.dailyLimit -= amount;
    this.quizzesCompleted += 1;
    this.updatedAt = new Date();
    
    // Incrementar streak
    this.streak += 1;
    
    // Level up cada 5 quizzes
    if (this.quizzesCompleted % 5 === 0) {
      this.levelUp();
    }
  }

  levelUp(): void {
    this.level += 1;
    this.dailyLimit = Math.min(50 + (this.level - 1) * 30, 500);
  }

  resetDailyLimit(): void {
    this.dailyLimit = Math.min(50 + (this.level - 1) * 30, 500);
  }
}