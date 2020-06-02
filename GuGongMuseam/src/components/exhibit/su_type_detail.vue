<template>
  <div class="su_type-con">
    <banner
      :navs="navs"
      :banner="banner"
      :title="title"
      @handleClick="getBanner"/>
    <bg class="su-detail">
      <div class="detail-con">
        <i class="el-icon-arrow-left" @click="$router.back(-1)" style="font-size: 40px;color: #ff413f;position: absolute;"></i>
        <p class="title" v-if="succinctDetail.data">{{succinctDetail.classname}}<span></span></p>
        <div class="detlist" v-if="succinctDetail.data.length!==0">
          <ul class="detail-list clearfix">
            <succinct-item
              v-for="(item,index) in succinctDetail.data"
              :key="index"
              :data="item">
            </succinct-item>
          </ul>
          <Pagination
            v-if="succinctDetail.total"
            :total="succinctDetail.total*10"
            :page="page"
            @handleChange="handlePage">
          </Pagination>
        </div>
        <no-data v-else></no-data>
      </div>
    </bg>
  </div>
</template>
<script type="text/ecmascript-6">
  import Banner from '@/base/banner'
  import {getAjax} from '@/public/js/config'
  import SuccinctItem from '@/base/exhibit/succinct_item'
  import Pagination from '@/base/pagination'
  import Bg from '@/base/bg'
  import NoData from '@/base/no-data'
  import {getSuccinct,getBanners} from "../../public/js/api";

  export default {

    components: {
      Banner,
      SuccinctItem,
      Pagination,
      Bg,
      NoData
    },
    data() {
      return {
        navs: [

        ],
        title: '藏品展示',
        succinctDetail: '',
        page: 1,
        banner:"",
      }
    },
    created() {

      this.getExhibitList()
      this.getBanner()
    },
    methods: {
      /**
       * 获取藏品精粹banner
       * @param id  分类id
       */
      getBanner() {
        var _this = this;
        getBanners({name:"藏品细节"}).then(res=>{
          _this.banner = res.data.img;
        })
      },
      /**
       * 获取分类列表
       */
      getExhibitList() {
        var _this = this;
        getSuccinct({id:parseInt(this.$route.query.id)}).then(res=>{
          _this.succinctDetail = res.data;
        })

      },
      /**
       * 获取分页页码
       * @param page
       */
      handlePage(page) {
        this.page = page;
        this.getExhibitList()
      },
    }
  }
</script>
<style lang="less">
  .el-icon-arrow-left{
    &:hover{
      cursor: pointer;
    }
  }
  .su-detail {
    width: 100%;
    .detail-con {
      width: 1200px;
      margin: 0 auto;
      padding-top: 50px;
      padding-bottom: 60px;
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
      .detail-list {
        width: 100%;
      }
    }
  }
</style>
