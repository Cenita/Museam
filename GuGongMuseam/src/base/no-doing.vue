<template>
  <div class="on-data">
    <!--没有数据组件-->
    <img :src="icon"/>
    <p class="txt">该部分尚未制作</p>
    <p class="txt">陈慧涛 - 陈林</p>
  </div>
</template>
<script type="text/ecmascript-6">
  export default {
    data() {
      return {
        icon: '../static/images/loading.png'
      }
    }
  }
</script>
<style lang="less">
  .on-data {
    width: 202px;
    text-align: center;
    margin: 0 auto;
    img{
      width: 100%;
    }
    .txt{
      font-size: 20px;
      color: #d2d2d2;
      padding-top: 20px;
      padding-bottom: 30px;
    }
  }
</style>
