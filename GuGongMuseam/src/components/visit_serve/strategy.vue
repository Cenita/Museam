<template>
  <div class="strategy">
    <banner
      :navs="navs"
      :banner="banner"
      :title="title"
      @handleClick="getBanner"/>
    <bg>
      <div class="strategy-con">
        <div class="open_time">
          <p class="title">旺季时间<span></span></p>
          <div class="wj">
            <div class="dt">
              <span>4月1日 到 10月31日</span>
            </div>
            <div class="cont">
              <div class="li" v-for="a in time_wang">
                <span class="tilt">{{a.title}}</span>
                <span class="time">{{a.time}}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="open_time">
          <p class="title">淡季时间<span style="background-image: linear-gradient(135deg, #1aeeff, #747cff);"></span></p>
          <div class="wj">
            <div class="dt">
              <span>11月1日 到 3月31日</span>
            </div>
            <div class="cont">
              <div class="li" v-for="a in time_dan">
                <span class="tilt">{{a.title}}</span>
                <span class="time">{{a.time}}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="map" style="text-align: center">
          <p class="title">展馆地图<span></span></p>
          <img src="../../assets/map.jpg" alt="">
        </div>
      </div>
    </bg>
  </div>
</template>
<script type="text/ecmascript-6">
  import Banner from '@/base/banner'
  import Bg from '@/base/bg'
  import NoData from '@/base/no-data'
  import {getBanners} from "../../public/js/api";
  import NoDoing from '@/base/no-doing';
  export default {
    components: {
      Banner,
      Bg,
      NoData,
      NoDoing
    },
    data() {
      return {
        navBar: [
          {title: '参观路线', id: 1},
        ],
        time_wang:[
          {
            title:"开始售票、开放进馆时间：",
            time:"8:30"
          },
          {
            title:"止票时间（含钟表馆、珍宝馆）：",
            time:"16:00"
          },
          {
            title:"停止入馆时间：",
            time:"16:10"
          },
          {
            title:"闭馆时间：",
            time:"17:00"
          }
        ],time_dan:[
          {
            title:"开始售票、开放进馆时间：",
            time:"8:30"
          },
          {
            title:"止票时间（含钟表馆、珍宝馆）：",
            time:"15:30"
          },
          {
            title:"停止入馆时间：",
            time:"15:40"
          },
          {
            title:"闭馆时间：",
            time:"16:30"
          }
        ],
        navs: [
          {
            href: '/visit_serve/strategy',
            title: '参观攻略',
            id: 1
          },
          {
            href: '/visit_serve/tickets',
            title: '门票预约',
            id: 2
          }
        ],
        title: '参观服务',
        typeId: 1,
        roadTypes: [],
        showImg: '',
        banner:""
      }
    },
    created() {
      this.getBanner()
      this.getTypeList()
      this.getShowImg('s')
    },
    methods: {
      /**
       * 获取参观攻略banner
       * @param id  分类id
       */
      getBanner() {
        var _this = this;
        getBanners({name:"参观攻略"}).then(res=>{
          _this.banner = res.data.img;
        })
      },

      handleTypeClick(typeId) {
        this.typeId = typeId
      },

      /**
       * 获取参观路线分类
       */
      getTypeList() {

      },

      toggleClick(id) {
        this.getShowImg(id)
      },

      /**
       * 获取参观路线对应id内容
       * @param id
       */
      getShowImg(id) {

      },

      //获取购票链接
      getTicketHref() {

      }
    }
  }
</script>
<style lang="less">
  .strategy-con {
    width: 1200px;
    margin: 0 auto;
    padding-top: 50px;
    padding-bottom: 60px;
  }
  .strategy-con{
    .open_time{
      &>*{
        margin-bottom: 50px;
      }
      .wj{
        text-align: center;
        font-family: "Microsoft YaHei UI";
        font-size: 25px;
        &>*{
          margin-top: 30px;
        }
        .dt{
          font-size: 35px;
        }
        .li{
          width: 700px;
          height: 50px;
          margin: auto;
          .tilt{
            float: left;
          }
          .time{
            float: right;
          }
        }
      }
    }
    .title {
      font-size: 22px;
      color: #666;
      text-align: center;
      margin-bottom: 50px;
      letter-spacing: 2px;
      span {
        width: 90px;
        height: 4px;
        display: block;
        margin: 10px auto;
        background-image: -webkit-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: -moz-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: -o-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: -ms-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: linear-gradient(135deg, #ff7d7f, #ff413f);
        -webkit-border-radius: 10px;
        -moz-border-radius: 10px;
        border-radius: 10px;
      }
    }
  }
</style>
