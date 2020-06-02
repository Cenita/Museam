import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

export default new Router({
    mode:"hash",
    routes: [
        {
            path: '/',
            redirect: '/dashboard'
        },
        {
            path: '/',
            component: () => import(/* webpackChunkName: "home" */ '../components/common/Home.vue'),
            meta: { title: '自述文件' },
            children: [
                {
                    path: '/dashboard',
                    component: () => import(/* webpackChunkName: "dashboard" */ '../components/page/Dashboard.vue'),
                    meta: { title: '系统首页' }
                },
                {
                    path: '/table',
                    component: () => import(/* webpackChunkName: "table" */ '../components/page/BaseTable.vue'),
                    meta: { title: '基础表格' }
                },
                {
                    path: '/banner',
                    component: () => import(/* webpackChunkName: "table" */ '../components/page/Banner.vue'),
                    meta: { title: '轮播图管理' }
                },
                {
                    path: '/people',
                    component: () => import(/* webpackChunkName: "table" */ '../components/page/People.vue'),
                    meta: { title: '人员管理' }
                },

                {
                    path: '/order',
                    component: () => import(/* webpackChunkName: "table" */ '../components/page/Order.vue'),
                    meta: { title: '预约管理' }
                },
                {
                    path: '/succinct',
                    component: () => import(/* webpackChunkName: "table" */ '../components/page/Succinct.vue'),
                    meta: { title: '展览馆管理' }
                },
                {
                    path: '/collection',
                    component: () => import(/* webpackChunkName: "table" */ '../components/page/Collection.vue'),
                    meta: { title: '藏品管理' }
                },
                {
                    path: '/exhibit',
                    component: () => import(/* webpackChunkName: "table" */ '../components/page/Exhibits.vue'),
                    meta: { title: '展览管理' }
                },
                {
                    path: '/question',
                    component: () => import(/* webpackChunkName: "tabs" */ '../components/page/Question.vue'),
                    meta: { title: '咨询管理' }
                },
                {
                    // vue-schart组件
                    path: '/charts',
                    component: () => import(/* webpackChunkName: "chart" */ '../components/page/BaseCharts.vue'),
                    meta: { title: 'schart图表' }
                },
                {
                    path: '/404',
                    component: () => import(/* webpackChunkName: "404" */ '../components/page/404.vue'),
                    meta: { title: '404' }
                },
            ]
        },
        {
            path: '/login',
            component: () => import(/* webpackChunkName: "login" */ '../components/page/Login.vue'),
            meta: { title: '后台管理系统登录' }
        },
        {
            path: '*',
            redirect: '/404'
        }
    ]
});
