<template>
  <div class="succinct-con">
    <banner
      :navs="navs"
      :banner="banner"
      :title="title"
      @handleClick="getBanner"/>
    <div class="type-con">
      <ul class="type_list clearfix">
          <li v-for="(item,index) in typeList.data" :key="index">
            <router-link :to="{path:'/exhibit/type-detail',query:{id:item.id}}">
              <div class="works-img">
                <img v-lazy="item.img"/>
              </div>
              <div  class="link-btn">
                {{item.classname}}
              </div>
            </router-link>

          </li>
        

      </ul>
      <no-data v-if="typeList.status===2"></no-data>
    </div>
  </div>
</template>
<script type="text/ecmascript-6">
  import Banner from '@/base/banner'
  import NoData from '@/base/no-data'
  import {getSuccincts,getBanners} from "../../public/js/api";

  export default {

    components: {
      Banner,
      NoData
    },
    data() {
      return {
        navs: [

        ],
        title: '藏品展示',
        typeList: '',
        banner:''
      }
    },
    created() {
      this.getBanner()
      this.getTypeList()
    },
    methods: {
      getBanner() {
        var _this = this;
        getBanners({name:"藏品首页"}).then(res=>{
          _this.banner = res.data.img;
        })
      },

      /**
       * 获取藏品精粹分类
       */
      getTypeList() {

        var _this = this;
        getSuccincts().then(res=>{
          _this.typeList = res;
        })
      }
    }
  }
</script>
<style scoped lang="less">
  .succinct-con {
    .type-con {
      width: 100%;
      padding-top: 50px;
      background: #f6f6f6 url("../../assets/bg.png") no-repeat;
      background-size: 100%;
      .type_list {
        width: 1200px;
        margin: 0 auto;
        padding-bottom: 60px;
        li {
          &:hover{
            cursor: pointer;
          }
          float: left;
          width: 290px;
          height: 210px;
          overflow: hidden;
          margin-right: 13px;
          margin-bottom: 13px;
          position: relative;
          -webkit-border-radius: 4px;
          -moz-border-radius: 4px;
          border-radius: 4px;
          box-shadow: 0 3px 36px 0 #EDEDED;
          .works-img {
            width: 100%;
            height: 210px;
            text-align: center;
            line-height: 210px;
            img {
              width: 100%;
              -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
              transition: opacity 0.35s, transform 0.35s;
              -webkit-transform: scale(1.15);
              transform: scale(1.15);
              backface-visibility: hidden;
              -webkit-backface-visibility: hidden;
            }
          }
          .link-btn {
            position: absolute;
            width: 150px;
            height: 40px;
            border-top-right-radius: 6px;
            border-bottom-right-radius: 6px;
            text-align: center;
            line-height: 40px;
            left: 0;
            top: 20px;
            background-image: linear-gradient(-131deg, #ff413f -16%, #ff7d7f 100%);
            color: #fff;
            font-size: 16px;
          }
          &:hover {
            img {
              -webkit-transform: scale(1.03);
              transform: scale(1.03);
            }
          }
          &:nth-of-type(4n) {
            margin-right: 0;
          }
        }
      }
    }
  }
</style>
