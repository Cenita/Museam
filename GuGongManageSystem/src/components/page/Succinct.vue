<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>
                    <i class="el-icon-lx-cascades"></i> 展览馆管理
                </el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button
                        type="primary"
                        icon="el-icon-delete"
                        class="handle-del mr10"
                        @click="add"
                >增加展览馆</el-button>
                <el-button
                        type="danger"
                        icon="el-icon-delete"
                        class="handle-del mr10"
                        @click="delAllSelection"
                >批量删除</el-button>
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
                <el-table-column prop="id" label="ID" width="155" align="center"></el-table-column>
                <el-table-column width="250" label="展馆图" align="center">
                    <template slot-scope="scope">
                        <el-image
                                class="table-td-thumb"
                                :src="scope.row.img"
                        ></el-image>
                    </template>
                </el-table-column>
                <el-table-column prop="classname" label="展馆名字"></el-table-column>
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
        <el-dialog title="编辑" :visible.sync="editVisible" width="30%">
            <el-form ref="form" :model="form" label-width="70px">
                <el-form-item label="展馆名字">
                    <el-input v-model="form.classname"></el-input>
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
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible=false">取 消</el-button>
                <el-button type="primary" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>

        <!-- 增加弹出框 -->
        <el-dialog title="增加展览馆" :visible.sync="addVisible" width="30%">
            <el-form ref="addForm" :model="addForm" label-width="70px">
                <el-form-item label="展馆名字">
                    <el-input v-model="addForm.classname"></el-input>
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
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="addVisible=false">取 消</el-button>
                <el-button type="primary" @click="addSuccinct">增 加</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import { getSuccincts,setSuccincts,addSuccincts,deleteSuccincts } from '../../api/index';
export default {
    name: 'Succinct',
    data() {
        return {
            query: {
                address: '',
                name: '',
                pageIndex: 1,
                pageSize: 10
            },
            addForm:{},
            tableData: [],
            multipleSelection: [],
            delList: [],
            addVisible:false,
            editVisible: false,
            pageTotal: 0,
            form: {},
            idx: -1,
            id: -1,
            imageUrl:""
        };
    },
    created() {
        this.getData();
    },
    methods: {
        // 获取 easy-mock 的模拟数据
        getData() {
            getSuccincts().then(res => {
                this.tableData = res.data;
                this.pageTotal = 1;
            });
        },
        fileList(response, file, fileList){
            var url = this.$url+"/"+response.list[0];
            this.imageUrl = url;
        },
        //增加操作
        add(){
            this.addForm = {};
            this.imageUrl = "";
          this.addVisible=true;
        },
        //增加展览馆
        addSuccinct(){
            this.addForm.img = this.imageUrl;
            if(this.addForm.img==""||this.addForm.classname==null){
                this.$message.error("请填写完整");
                return;
            }
            addSuccincts(this.addForm).then(res=>{
                if(res.status==='200'){
                    this.$message.success("增加成功");
                    this.addVisible=false;
                    this.getData();
                    this.addForm={};
                }
            })
        },
        // 触发搜索按钮
        handleSearch() {
            this.$set(this.query, 'pageIndex', 1);
            this.getData();
        },
        // 删除操作
        handleDelete(index, row) {
            // 二次确认删除
            this.$confirm('确定要删除吗？', '提示', {
                type: 'warning'
            })
                .then(() => {
                    deleteSuccincts({id:row.id}).then(res=>{
                        if(res.status==='200'){
                            this.$message.success('删除成功');
                            this.getData();
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
                deleteSuccincts({id:this.multipleSelection[i].id}).then(res=>{
                    if(res.status==='200'){
                        this.$message.success('删除成功');
                        this.getData();
                    }
                })
            }
            this.multipleSelection = [];
        },
        // 编辑操作
        handleEdit(index, row) {
            this.idx = index;
            this.form = row;
            this.editVisible = true;
            this.imageUrl = row.img;
        },
        // 保存编辑
        saveEdit() {
            this.editVisible = false;
            this.form.img = this.imageUrl;
            setSuccincts(this.form).then(res=>{
                if(res.status==='200'){
                    this.$message.success(`修改第 ${this.idx + 1} 行成功`);
                    this.$set(this.tableData, this.idx, this.form);
                }
            })

        },
        // 分页导航
        handlePageChange(val) {
            this.$set(this.query, 'pageIndex', val);
            this.getData();
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
    width: 200px;
}
</style>
