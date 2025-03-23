import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        user: {
            account: null,
        }
    },
    mutations: {
        setAccount(state, account) {
            state.user.account = account;
        }
    },
    actions: {
        updateAccount({ commit }, account) {
            commit('setAccount', account);
        }
    },
    getters: {
        userAccount: state => state.user.account
    },
    plugins: [
        createPersistedState({
            key: 'my-vuex-store', // 可选，默认是vuex
            paths: ['user'] // 只持久化user状态
        })
    ]
});

