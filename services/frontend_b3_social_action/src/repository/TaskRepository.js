import api from '@/plugins/axios';

export class TaskRepository {
  constructor() {
    this.api = api;
  }

  async list(page, size) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : {};

    const response = await this.api.get(`task?page=${page}&size=${size}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    return response;
  }

  async get(id) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.get(`task/${id}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    return response;
  }

  async create(data) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';
    const response = await this.api.post('task', data, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    return response.data;
  }

  async update(data, id) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.put(`task/${id}`, data, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    return response.data;
  }

  async delete(id) {
    const token = sessionStorage.getItem('token') !== null ? sessionStorage.getItem('token') : '';

    const response = await this.api.delete(`task/${id}`, {
      headers: `Bearer ${token}`,
    });
    return response.data;
  }
}
