import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
//主页
const Home = () => import('@/components/Home')
//登录页面
const SignIn = () => import('@/components/SignIn')
//注册页面
const SignUp = () => import('@/components/SignUp')
//藏品展示页面
const Exhibit = () => import('@/components/Exhibit')
const Succinct = () => import('@/components/exhibit/succinct')
const TypeDetail = () => import('@/components/exhibit/su_type_detail')
const SuccinctDetail = () => import('@/components/exhibit/succinct_detail')
//活动展览页面
const Patch_exhibt = () => import('@/components/Patch_exhibt')
const Patch_info = () => import('@/components/patch_exhibit/patch_info')
const Patch_detail = () => import('@/components/patch_exhibit/patch_detail')
//参观服务页面
const Visit_serve = () => import('@/components/Visit_serve')
const Strategy = () => import('@/components/visit_serve/strategy')
const Tickets = () => import('@/components/visit_serve/tickets')

//咨询问答页面
const Questions = () => import('@/components/Questions')
const Question = () => import('@/components/questions/question')


export default new Router({
  mode: "hash",
  routes: [
    {
      path: '/',
      name: '首页',
      component: Home,
      meta: ['首页'],
    },
    {
      path: '/signIn',
      name: '登录',
      meta: ['登录'],
      components: {
        'sign': SignIn
      }
    },
    {
      path: '/signUp',
      name: '注册',
      meta: ['注册'],
      components: {
        'sign': SignUp
      }
    },
    {
      path: '/exhibit',
      name: '藏品展示',
      component: Exhibit,
      children: [
        {
          path: 'succinct',
          name: '藏品展示',
          component: Succinct,
          meta: ['藏品展示'],
        },
        {
          path: 'type-detail',
          name: '藏品展示',
          component: TypeDetail,
          meta: ['藏品展示'],
        },
        {
          path: 'succinct-detail',
          name: '藏品展示',
          component: SuccinctDetail,
          meta: ['藏品展示'],
        },
      ]
    },
    {
      path: '/patch',
      name: '活动展览',
      component: Patch_exhibt,
      children: [
        {
          path: 'patch_info',
          component: Patch_info,
          name: '活动展览',
          meta: ['活动展览'],
        },
        {
          path: 'patch-detail',
          component: Patch_detail,
          name: '详情',
          meta: ['活动展览'],
        },
      ]
    },
    {
      path: '/visit_serve',
      name: '参观服务',
      component: Visit_serve,
      children: [
        {
          path: 'strategy',
          name: '参观攻略',
          component: Strategy,
          meta: ['参观服务', '参观攻略'],
        },
        {
          path: 'tickets',
          name: '门票预约',
          component: Tickets,
          meta: ['参观服务', '门票预约'],
        },

      ]
    },
    {
      path: '/questions',
      name: '咨询问答',
      component: Questions,
      children: [
        {
          path:'answers',
          name:'问题回答',
          component:Question,
          meta:['咨询问答','问题回答']
        }
      ]
    }
  ]
})
