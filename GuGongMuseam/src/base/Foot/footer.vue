<template>
  <div class="footer">
    <div class="contact">

    </div>
    <div class="count">
      <p>浏览人数</p>
      <span v-for="(item,index) in counts" :key="index">
        {{item}}
      </span>
    </div>
    <div class="copyright">
    </div>
  </div>
</template>
<script type="text/ecmascript-6">

  export default {
    props: {
      number: {
        type: String,
        default: ''
      }
    },
    data() {
      const _this = this
      return {
      }
    },
    computed: {
      /**
       * 浏览人数
       * @returns {Array}
       */
      counts() {
        const numArr = []
        const num = this.number.toString()
        for (let i = 0; i < num.length; i++) {
          numArr.push(num.substr(i, 1))
        }
        return numArr
      }
    }
  }
</script>
<style lang="less">
  .footer {
    background-color: #2b3340;
    color: #5e7482;
    padding-top: 30px;
    min-width: 1400px;
    .contact {
      padding-bottom: 30px;
      border-bottom: 1px solid #3f4754;
      ul {
        width: 100%;
        text-align: center;
        li {
          width: 340px;
          text-align: center;
          display: inline-block;
          vertical-align: middle;
          border-left: 1px solid #3f4754;
          padding: 26px 0;
          .title {
            color: #fff;
            font-size: 16px;
            margin-bottom: 8px;
          }
          .phone {
            font-size: 18px;
          }
          &:last-child {
            border-right: 1px solid #3f4754;
          }
        }
      }
    }
    .agreement {
      padding: 25px 0;
      border-bottom: 1px solid #3f4754;
      text-align: center;
      .item {
        display: inline-block;
        vertical-align: top;
        width: 200px;
        text-align: center;
        margin-right: 150px;
        .title {
          padding-bottom: 10px;
          font-size: 16px;
        }
        a {
          color: #5e7482;
          font-size: 16px;
          display: block;
          margin-bottom: 10px;
        }
        img {
          width: 80px;
          border: 5px solid #fff;
          -webkit-border-radius: 2px;
          -moz-border-radius: 2px;
          border-radius: 2px;
          height: 100%;
        }
        .ewm-txt {
          font-size: 14px;
          margin-top: 10px;
        }
        &:last-child {
          margin-right: 0;
        }
        .ivu-select-dropdown {
          max-height: 126px;
          .ivu-select-dropdown-list {
            .ivu-select-item-selected {
              a {
                color: #fff;
              }
            }
            .ivu-select-item {
              padding: 0;
              a {
                padding: 7px;
              }
            }
          }
        }
      }
    }
    .count {
      text-align: center;
      font-size: 14px;
      padding: 15px 0;
      p {
        display: inline-block;
        margin-right: 10px;
      }
      span {
        width: 25px;
        height: 25px;
        display: inline-block;
        text-align: center;
        line-height: 25px;
        background-color: #3f475a;
        -webkit-border-radius: 2px;
        -moz-border-radius: 2px;
        border-radius: 2px;
        margin-right: 5px;
        color: #fff;
      }
    }
    .copyright {
      text-align: center;
      color: #fff;
      font-size: 14px;
      padding: 15px 0;
      background: #141c29;
    }
  }
</style>
