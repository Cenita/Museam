<template>
  <div class="patch-con">
    <banner
      :navs="navs"
      :banner="banner"
      :title="title"
      @handleClick="getBanner"/>
    <bg class="patch-list">
      <div class="info-con">
        <nav-bar :navBar="navBar"
                 @handleClick="handleTypeClick">
        </nav-bar>
        <div class="lists" v-if="patchData.data.length!==0">
          <patch-item
                      @reflush="getPatchList"
                      v-for="(item,index) in patchData.data"
                      :key="index"
                      :patch_data="item"
                      :type="type">
          </patch-item>
        </div>
        <no-data v-else></no-data>

        <Pagination v-if="patchData.total"
                    :total="patchData.total*10"
                    :page="page"
                    @handleChange="handlePage">
        </Pagination>

      </div>
    </bg>
  </div>
</template>
<script type="text/ecmascript-6">
  import NavBar from '@/base/navBar'
  import PatchItem from '@/base/patch/patch_item'
  import Pagination from '@/base/pagination'
  import Banner from '@/base/banner'
  import Bg from '@/base/bg'
  import NoData from '@/base/no-data'
  import {getExhibits,getBanners} from "../../public/js/api";

  export default {
    components: {
      NavBar,
      PatchItem,
      Pagination,
      Banner,
      Bg,
      NoData
    },
    data() {
      return {
        navBar: [
          {title: '正在展览', id: 1},
          {title: '即将展览', id: 2},
          {title: '展览回顾', id: 3},
        ],
        patchData: '',
        page: 1,  //页码
        type: 1,   //查询条件
        title: '活动展览',
        navs: [
        ],
        banner:""
      }
    },
    created() {
      this.getBanner()
      this.getPatchList()
      setTimeout(()=>{
        if(this.$store.state.islogin){
          this.navBar.push({title: '我的预约', id: 4});
        }
      },50);

    },
    methods: {
      handlePage(page) {
        this.page = page
        this.getPatchList()
      },
      handleTypeClick(typeId) {
        this.type = typeId
        this.page = 1
        this.getPatchList()
      },
      getPatchList() {
        var _this = this;
        getExhibits({type:_this.type}).then(res=>{
          _this.patchData = res.data;
        })
      },
      getBanner() {
        var _this = this;
        getBanners({name:"展览首页"}).then(res=>{
          _this.banner = res.data.img;
        })
      }
    }
  }
</script>
<style scoped lang="less">
  .patch-list {
    padding-top: 50px;
    padding-bottom: 60px;
    .info-con {
      width: 1200px;
      margin: 0 auto;
    }
  }
</style>
