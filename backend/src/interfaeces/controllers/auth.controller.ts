import { Request, Response } from 'express';
import { UserService } from '../../application/UserService.js';
import { JWTService } from '../../infrastructure/auth/jwt.js';

export class AuthController {
  private userService: UserService;
  private jwtService: JWTService;

  constructor() {
    this.userService = new UserService();
    this.jwtService = new JWTService();
  }

  async register(req: Request, res: Response) {
    try {
      const { email, name } = req.body;

      if (!email || !name) {
        return res.status(400).json({ error: 'Email and name are required' });
      }

      // Verificar si el usuario ya existe
      const existingUser = await this.userService.getUserByEmail(email);
      if (existingUser) {
        return res.status(400).json({ error: 'User already exists' });
      }

      // Crear usuario
      const user = await this.userService.createUser(email, name);

      // Generar token
      const token = this.jwtService.generateToken({
        userId: user.id,
        email: user.email
      });

      res.status(201).json({
        success: true,
        data: {
          user: {
            id: user.id,
            email: user.email,
            name: user.name,
            level: user.level,
            totalSats: user.totalSats
          },
          token
        }
      });

    } catch (error: any) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }

  async login(req: Request, res: Response) {
    try {
      const { email } = req.body;

      if (!email) {
        return res.status(400).json({ error: 'Email is required' });
      }

      const user = await this.userService.getUserByEmail(email);
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }

      // Generar token
      const token = this.jwtService.generateToken({
        userId: user.id,
        email: user.email
      });

      res.json({
        success: true,
        data: {
          user: {
            id: user.id,
            email: user.email,
            name: user.name,
            level: user.level,
            totalSats: user.totalSats,
            dailyLimit: user.dailyLimit,
            streak: user.streak
          },
          token
        }
      });

    } catch (error: any) {
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  }
}