import axios from 'axios';
import { env } from '../../config/env.js';

export interface PaymentResult {
  payment_hash: string;
  payment_request: string;
  success: boolean;
}

export class LNBitsService {
  private readonly baseURL: string;
  private readonly headers: Record<string, string>;

  constructor() {
    this.baseURL = env.LNBITS_URL;
    this.headers = {
      'X-Api-Key': env.LNBITS_ADMIN_KEY,
      'Content-Type': 'application/json'
    };
  }

  async sendPayment(amount: number, memo: string): Promise<PaymentResult> {
    try {
      const response = await axios.post(
        `${this.baseURL}/api/v1/payments`,
        {
          out: true,
          amount: amount * 1000, // Convertir a milisats
          memo: memo,
          webhook: `${env.LNBITS_URL}/webhook/edusats`
        },
        { headers: this.headers, timeout: 30000 }
      );

      return {
        payment_hash: response.data.payment_hash,
        payment_request: response.data.payment_request,
        success: true
      };
    } catch (error: any) {
      console.error('LNBits payment error:', error.response?.data || error.message);
      throw new Error(`Failed to send payment: ${error.response?.data?.detail || error.message}`);
    }
  }

  async checkPayment(paymentHash: string): Promise<boolean> {
    try {
      const response = await axios.get(
        `${this.baseURL}/api/v1/payments/${paymentHash}`,
        { headers: this.headers }
      );

      return response.data.paid;
    } catch (error) {
      return false;
    }
  }
}