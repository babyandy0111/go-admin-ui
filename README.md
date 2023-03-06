# README

## 關於

這是業績系統的前端

---------------------------------------

## 技術棧
1. vue
2. go-admin-ui
3. Element UI
4. docker

## 目前有
1. User管理：新增帳號與帳號基本資料設定。
2. 部門管理：部門管理。
3. 職位管理：職位管理。
4. 選單管理：配置系統選單，操作權限，按鈕權限，API權限等。
5. 角色管理：角色選單權限分配。
6. 字典管理：對系統中經常使用的一些較為固定的資料進行維護。
7. 基本的 sales explorers

## 如何開始開發
1. 確認後端API Server已經啟動
2. 安裝vue2 & nodejs(v16) & npm & yarn
3. clone repo
4. cd repo
5. yarn && yarn dev


## 目錄結構
```base 
├── build                   # 開發時，preview用的
├── plop-templates          # 元件layout
├── scripts                 # 部署需要的腳本
├── src                     # 主要的程式碼
│   ├── api                 # 串接api的func
│   ├── assets              # 靜態資源
│   ├── components          # 元件都放這
│   ├── dircetive           
│   ├── filter              # filter的操作
│   ├── icons               # icons
│   ├── layout              # layout
│   ├── router              # router
│   ├── store               # store的操作
│   ├── styles              # css
│   ├── utils               # 共用func
│   ├── vendor              # 匯入匯出Excel
│   └── views               # 幾乎所有的顯示都在這出發       
├── Dockerfile
└── README.md
```