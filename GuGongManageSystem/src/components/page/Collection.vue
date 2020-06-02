<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>
                    <i class="el-icon-lx-cascades"></i> 藏品管理
                </el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button
                        type="primary"
                        icon="el-icon-delete"
                        class="handle-del mr10"
                        @click="addCollection"
                >增加藏品</el-button>
                <el-button
                        type="danger"
                        icon="el-icon-delete"
                        class="handle-del mr10"
                        @click="delAllSelection"
                >批量删除</el-button>
                <el-select v-model="query.address" @change="getData" placeholder="展览馆" class="handle-select mr10">
                    <el-option key="0" label="全部展馆" value="-1"></el-option>
                    <el-option :key="index+1" v-for="(item,index) in succincts" :label="item.classname" :value="item.id"></el-option>
                </el-select>
                <el-input v-model="query.name" placeholder="藏品标题" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
            </div>
            <el-table
                :data="tableData"
                border
                class="table"
                ref="multipleTable"
                header-cell-class-name="table-header"
                @selection-change="handleSelectionChange"
            >
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column prop="id" label="ID" width="55" align="center"></el-table-column>
                <el-table-column prop="title" label="藏品标题"></el-table-column>
                <el-table-column prop="succinct_name" label="所属展馆"></el-table-column>
                <el-table-column label="藏品图" align="center" width="300">
                    <template slot-scope="scope">
                        <el-image
                                style="width: 100px;"
                                class="table-td-thumb"
                                :src="scope.row.img"
                        ></el-image>
                    </template>
                </el-table-column>
                <el-table-column label="热度">
                    <template slot-scope="scope">{{scope.row.hot}}</template>
                </el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button
                            type="text"
                            icon="el-icon-edit"
                            @click="handleEdit(scope.$index, scope.row)"
                        >编辑</el-button>
                        <el-button
                            type="text"
                            icon="el-icon-delete"
                            class="red"
                            @click="handleDelete(scope.$index, scope.row)"
                        >删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div class="pagination">
                <el-pagination
                    background
                    layout="total, prev, pager, next"
                    :current-page="query.pageIndex"
                    :page-size="query.pageSize"
                    :total="pageTotal"
                    @current-change="handlePageChange"
                ></el-pagination>
            </div>
        </div>

        <!-- 编辑弹出框 -->
        <el-dialog title="编辑藏品" :visible.sync="editVisible" width="30%">
            <el-form ref="form" :model="form" label-width="70px">
                <el-form-item label="藏品标题">
                    <el-input v-model="form.title"></el-input>
                </el-form-item>
                <el-form-item label="藏品介绍">
                    <el-input type="textarea" v-model="form.introduce"></el-input>
                </el-form-item>
                <el-form-item label="上传图片">
                    <el-upload
                            action="http://localhost:4269/api/Image"
                            :show-file-list="false"
                            :on-success="fileList">
                        <img v-if="imageUrl" :src="imageUrl" style="width: 100%;height: 100%" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="所属展馆">
                    <el-select style="width: 100%" v-model="form.succinct_id" placeholder="展览馆" class="handle-select mr10">
                        <el-option key="1" v-for="(item,index) in succincts" :label="item.classname" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible=false">取 消</el-button>
                <el-button type="primary" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>
        <!-- 增加弹出框 -->
        <el-dialog title="增加藏品" :visible.sync="addVisible" width="30%">
            <el-form ref="addForm" :model="addForm" label-width="70px">
                <el-form-item label="藏品标题">
                    <el-input v-model="addForm.title"></el-input>
                </el-form-item>
                <el-form-item label="藏品介绍">
                    <el-input type="textarea" v-model="addForm.introduce"></el-input>
                </el-form-item>
                <el-form-item label="上传图片">
                    <el-upload
                            action="http://localhost:4269/api/Image"
                            :show-file-list="false"
                            :on-success="fileList">
                        <img v-if="imageUrl" :src="imageUrl" style="width: 100%;height: 100%" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="所属展馆">
                    <el-select style="width: 100%" v-model="addForm.succinct_id" placeholder="展览馆" class="handle-select mr10">
                        <el-option key="1" v-for="(item,index) in succincts" :label="item.classname" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="addVisible=false">取 消</el-button>
                <el-button type="primary" @click="add">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import { getCollections,getSuccincts,setCollections,deleteCollections,addCollections } from '../../api/index';
export default {
    name: 'basetable',
    data() {
        return {
            query: {
                address: '-1',
                name: '',
                pageIndex: 1,
                pageSize: 8
            },
            allDate:[],
            succincts:[],
            tableData: [],
            multipleSelection: [],
            delList: [],
            addVisible:false,
            editVisible: false,
            pageTotal: 50,
            form: {},
            addForm: {},
            idx: -1,
            id: -1,
            imageUrl:""
        };
    },
    created() {
        this.getData();
        this.getSuccinct();
    },
    methods: {
        fileList(response, file, fileList){
            var url = this.$url+"/"+response.list[0];
            this.imageUrl = url;
        },
        addCollection(){
          this.addVisible=true;
          this.addForm={};
          this.imageUrl="";
        },
        // 获取 easy-mock 的模拟数据
        getData() {
            getCollections(this.query).then(res => {
                this.allDate = res.data;
                this.query.pageIndex = 1;
                this.tableData = this.allDate.slice(0,this.query.pageSize)
                this.pageTotal = this.allDate.length;
            });
        },
        getSuccinct(){
            getSuccincts().then(res=>{
                this.succincts = res.data;
            })
        },
        add(){
            this.addForm.img = this.imageUrl;
            if(this.addForm.img==""||this.addForm.introduce==null||this.addForm.succinct_id==null||this.addForm.title==null){
                this.$message.error("请填写完整");
                return;
            }
            addCollections(this.addForm).then(res=>{
                if(res.status==='200'){
                    this.$message.success('增加成功');
                    this.addVisible=false;
                    this.getData();
                    this.addForm={};
                }
            })
        },
        // 触发搜索按钮
        handleSearch() {
            this.getData();
        },
        // 删除操作
        handleDelete(index, row) {
            // 二次确认删除
            this.$confirm('确定要删除吗？', '提示', {
                type: 'warning'
            })
                .then(() => {
                    deleteCollections({id:row.id}).then(res=>{
                        if(res.status==='200'){
                            this.$message.success('删除成功');
                            this.getData();
                        }else{
                            this.$message.error("删除失败");
                        }
                    })
                })
                .catch(() => {});
        },
        // 多选操作
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        delAllSelection() {
            const length = this.multipleSelection.length;
            this.delList = this.delList.concat(this.multipleSelection);
            for (let i = 0; i < length; i++) {
                deleteCollections({id:this.multipleSelection[i].id}).then(res=>{
                    if(res.status==='200'){
                        this.$message.success('删除成功');
                    }
                })
            }
            this.multipleSelection = [];
        },
        // 编辑操作
        handleEdit(index, row) {
            this.idx = index;
            this.form = row;
            this.imageUrl = row.img;
            this.editVisible = true;
        },
        // 保存编辑
        saveEdit() {
            this.form.img = this.imageUrl;
            setCollections(this.form).then(res=>{
                if(res.status==='200'){
                    this.editVisible = false;
                    this.$message.success(`修改第 ${this.idx + 1} 行成功`);
                    this.$set(this.tableData, this.idx, this.form);
                }else{
                    this.$message.error(`修改第 ${this.idx + 1} 行失败`);
                }
            })
        },
        // 分页导航
        handlePageChange(val) {
            this.query.pageIndex = val;
            this.tableData = this.allDate.slice((this.query.pageIndex-1)*8,(this.query.pageIndex)*8)
        }
    }
};
</script>

<style scoped>
.handle-box {
    margin-bottom: 20px;
}

.handle-select {
    width: 120px;
}

.handle-input {
    width: 300px;
    display: inline-block;
}
.table {
    width: 100%;
    font-size: 14px;
}
.red {
    color: #ff0000;
}
.mr10 {
    margin-right: 10px;
}
.table-td-thumb {
    display: block;
    margin: auto;
    width: 100px;
}
</style>
