export default {
  namespaced: true,
  state: {
    items: [
      {
        text: 'Inicio',
        toPageName: 'ListPublicSocialActionView',
        permission: 'non-permission-needed',
      },
      {
        text: 'Criar Ação Social',
        toPageName: 'CreateSocialActionView',
        permission: 'CREATE_SOCIAL_ACTION',
      },
      {
        text: 'Criar Tarefa',
        toPageName: 'CreateTaskView',
        permission: 'CREATE_TASK',
      },
      {
        text: 'Ação Social',
        toPageName: 'ListPrivateSocialActionView',
        permission: 'non-permission-needed',
      },

    ],
  },
};
