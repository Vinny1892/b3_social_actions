import api from '@/plugins/axios';

export class SocialActionRepository {
  constructor() {
    this.api = api;
  }

  async listPublic(page, size) {
    const response = await this.api.get(`social_actions/public?page=${page}&size=${size}`);
    return response.data;
  }

  async listPrivate(page, size) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.get(`social_actions/private?page=${page}&size=${size}`, {
      headers: {
        Authorization: `Bearer ${token}`,

      },
    });
    return response.data;
  }

  async get(id) {
    const response = await this.api.get(`social_actions/${id}`);
    return response.data;
  }

  async search(value) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.get(`social_actions/search/${value}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    return response.data;
  }

  async create(data) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.post('social_actions', data, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    return response.data;
  }

  async update(data, id) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.put(`social_actions/${id}`, data, {
      Authorization: `Bearer ${token}`,
    });
    return response.data;
  }

  async delete(id) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.delete(`social_actions/${id}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    return response.data;
  }
}
