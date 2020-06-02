<template>
  <!--子页面黄色大标题-->
  <div class="banner">
    <div class="navs">
      <div class="navs-con">
        <p class="title">{{title}}</p>
        <ul class="guides">
          <li v-for="(item,index) in navs"
              :key="index">
            <router-link :to="item.href"
                         :class="pathname===item.title ? 'active' : ''"
                         @click.native="handleClick(item.id)">
              {{item.title}}
            </router-link>
          </li>
        </ul>
      </div>
    </div>
    <div class="banner-img"
         :style="{background: 'url('+($route.query.img ? $route.query.img : banner)+') no-repeat center'}"
         :class="{filter:isDetail==='详情'}">
    </div>
    <div :class="{mask:isDetail==='详情'}"></div>
  </div>
</template>
<script type="text/ecmascript-6">
  export default {
    props: {
      title: {
        type: String,
        default: ''
      },
      banner: {
        type: String,
        default: ''
      },
      mold: {
        type: String,
        default: 'movie_detail'
      },
      navs: {
        type: Array,
        default: ''
      }
    },
    data() {
      return {
        num: 0,
        pathname: '',
        isDetail: ''
      }
    },
    mounted() {
      this.isDetail=this.$route.name
      this.pathname = this.$route.meta[1]
    },
    methods: {
      handleClick(id) {
        this.$emit('handleClick', id)
      }
    },
    watch: {
      "$route"(to, from) {
        this.isDetail = to.name
        this.pathname = to.meta[1]
      }
    }
  }
</script>
<style scoped lang="less">
  .banner {
    width: 100%;
    height: 560px;
    position: relative;
    overflow: hidden;
    .banner-img {
      background-size: cover !important;
      width: 100%;
      height: 560px;
    }
    .filter {
      -webkit-filter: blur(10px);
      transform: scale(1.2);
    }
    .navs {
      width: 100%;
      height: 80px;
      background: rgba(199, 138, 134, 0.5);
      position: absolute;
      top: 0;
      left: 0;
      z-index: 20;
      .navs-con {
        width: 1200px;
        margin: 0 auto;
        .title {
          font-size: 30px;
          color: #fff;
          margin-right: 20px;
          display: inline-block;
          line-height: 80px;
          vertical-align: middle;
        }
        .guides {
          display: inline-block;
          vertical-align: middle;
          li {
            display: inline-block;
            font-size: 16px;
            margin-right: 4px;
            a {
              padding: 9px 28px;
              color: #fff;
              display: inline-block;
              -webkit-border-radius: 3px;
              -moz-border-radius: 3px;
              border-radius: 3px;
              &.active {
                background-image: -webkit-linear-gradient(135deg, #b93127, #972722);
                background-image: -moz-linear-gradient(135deg, #b93127, #972722);
                background-image: -o-linear-gradient(135deg, #b93127, #972722);
                background-image: -ms-linear-gradient(135deg, #b93127, #972722);
                background-image: linear-gradient(135deg, #b93127, #972722);
              }
              &:hover {
                background-image: -webkit-linear-gradient(135deg, #b93127, #972722);
                background-image: -moz-linear-gradient(135deg, #b93127, #972722);
                background-image: -o-linear-gradient(135deg, #b93127, #972722);
                background-image: -ms-linear-gradient(135deg, #b93127, #972722);
                background-image: linear-gradient(135deg, #b93127, #972722);
              }
            }
          }
        }
      }
    }
    .mask{
      position: absolute;
      top: 0;
      left: 0;
      right:0;
      bottom: 0;
      background: rgba(0,0,0,.3);
    }
  }
</style>
