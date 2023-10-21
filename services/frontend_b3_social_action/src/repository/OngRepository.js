import api from '@/plugins/axios';

export class OngRepository {
  // eslint-disable-next-line no-useless-constructor,no-empty-function
  constructor() {
    this.api = api;
  }

  async list(page, size) {
    const response = await this.api.get(`social_actions?page=${page}&size=${size}`);
    return response;
  }

  async search(name) {
    const response = await this.api.get(`ong/${name}`);
    return response.data;
  }
}
