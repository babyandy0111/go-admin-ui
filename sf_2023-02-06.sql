# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.7.4-MariaDB-1:10.7.4+maria~focal-log)
# Database: sf
# Generation Time: 2023-02-06 08:40:12 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table sys_api
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_api`;

CREATE TABLE `sys_api` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主鍵編碼',
  `handle` varchar(128) DEFAULT NULL COMMENT 'handle',
  `title` varchar(128) DEFAULT NULL COMMENT '標題',
  `path` varchar(128) DEFAULT NULL COMMENT '地址',
  `type` varchar(16) DEFAULT NULL COMMENT '接口類型',
  `action` varchar(16) DEFAULT NULL COMMENT '請求類型',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`),
  KEY `idx_sys_api_deleted_at` (`deleted_at`),
  KEY `idx_sys_api_create_by` (`create_by`),
  KEY `idx_sys_api_update_by` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_api` WRITE;
/*!40000 ALTER TABLE `sys_api` DISABLE KEYS */;

INSERT INTO `sys_api` (`id`, `handle`, `title`, `path`, `type`, `action`, `created_at`, `updated_at`, `deleted_at`, `create_by`, `update_by`)
VALUES
	(5,'go-admin/app/admin/apis.SysLoginLog.Get-fm','登錄日誌通過id獲取','/api/v1/sys-login-log/:id','BUS','GET','2021-05-13 19:59:00.728','2023-02-03 17:11:20.583',NULL,0,0),
	(6,'go-admin/app/admin/apis.SysOperaLog.GetPage-fm','操作日誌列表','/api/v1/sys-opera-log','BUS','GET','2021-05-13 19:59:00.778','2023-02-03 17:11:20.583',NULL,0,0),
	(7,'go-admin/app/admin/apis.SysOperaLog.Get-fm','操作日誌通過id獲取','/api/v1/sys-opera-log/:id','BUS','GET','2021-05-13 19:59:00.821','2023-02-03 17:11:20.583',NULL,0,0),
	(8,'go-admin/common/actions.IndexAction.func1','分類列表','/api/v1/syscategory','BUS','GET','2021-05-13 19:59:00.870','2023-02-03 17:11:20.583',NULL,0,0),
	(9,'go-admin/common/actions.ViewAction.func1','分類通過id獲取','/api/v1/syscategory/:id','BUS','GET','2021-05-13 19:59:00.945','2023-02-03 17:11:20.583',NULL,0,0),
	(10,'go-admin/common/actions.IndexAction.func1','內容列表','/api/v1/syscontent','BUS','GET','2021-05-13 19:59:01.005','2023-02-03 17:11:20.583',NULL,0,0),
	(11,'go-admin/common/actions.ViewAction.func1','內容通過id獲取','/api/v1/syscontent/:id','BUS','GET','2021-05-13 19:59:01.056','2023-02-03 17:11:20.583',NULL,0,0),
	(15,'go-admin/common/actions.IndexAction.func1','job列表','/api/v1/sysjob','BUS','GET','2021-05-13 19:59:01.248','2023-02-03 17:11:20.583',NULL,0,0),
	(16,'go-admin/common/actions.ViewAction.func1','job通過id獲取','/api/v1/sysjob/:id','BUS','GET','2021-05-13 19:59:01.298','2023-02-03 17:11:20.583',NULL,0,0),
	(21,'go-admin/app/admin/apis.SysDictType.GetPage-fm','字典類型列表','/api/v1/dict/type','BUS','GET','2021-05-13 19:59:01.525','2023-02-03 17:11:20.583',NULL,0,0),
	(22,'go-admin/app/admin/apis.SysDictType.GetAll-fm','字典類型查詢【代碼生成】','/api/v1/dict/type-option-select','SYS','GET','2021-05-13 19:59:01.582','2023-02-03 17:11:20.583',NULL,0,0),
	(23,'go-admin/app/admin/apis.SysDictType.Get-fm','字典類型通過id獲取','/api/v1/dict/type/:id','BUS','GET','2021-05-13 19:59:01.632','2023-02-03 17:11:20.583',NULL,0,0),
	(24,'go-admin/app/admin/apis.SysDictData.GetPage-fm','字典資料列表','/api/v1/dict/data','BUS','GET','2021-05-13 19:59:01.684','2023-02-03 17:11:20.583',NULL,0,0),
	(25,'go-admin/app/admin/apis.SysDictData.Get-fm','字典資料通過code獲取','/api/v1/dict/data/:dictCode','BUS','GET','2021-05-13 19:59:01.732','2023-02-03 17:11:20.583',NULL,0,0),
	(26,'go-admin/app/admin/apis.SysDictData.GetSysDictDataAll-fm','資料字典根據key獲取','/api/v1/dict-data/option-select','SYS','GET','2021-05-13 19:59:01.832','2023-02-03 17:11:20.583',NULL,0,0),
	(27,'go-admin/app/admin/apis.SysDept.GetPage-fm','部門列表','/api/v1/dept','BUS','GET','2021-05-13 19:59:01.940','2023-02-03 17:11:20.583',NULL,0,0),
	(28,'go-admin/app/admin/apis.SysDept.Get-fm','部門通過id獲取','/api/v1/dept/:id','BUS','GET','2021-05-13 19:59:02.009','2023-02-03 17:11:20.583',NULL,0,0),
	(29,'go-admin/app/admin/apis.SysDept.Get2Tree-fm','查詢部門下拉樹【角色權限-自定權限】','/api/v1/deptTree','SYS','GET','2021-05-13 19:59:02.050','2023-02-03 17:11:20.583',NULL,0,0),
	(30,'go-admin/app/admin/apis/tools.(*Gen).GetDBTableList-fm','資料庫表列表','/api/v1/db/tables/page','SYS','GET','2021-05-13 19:59:02.098','2023-02-03 17:11:20.583',NULL,0,0),
	(31,'go-admin/app/admin/apis/tools.(*Gen).GetDBColumnList-fm','資料表列列表','/api/v1/db/columns/page','SYS','GET','2021-05-13 19:59:02.140','2023-02-03 17:11:20.583',NULL,0,0),
	(32,'go-admin/app/admin/apis/tools.Gen.GenCode-fm','資料庫表生成到項目','/api/v1/gen/toproject/:tableId','SYS','GET','2021-05-13 19:59:02.183','2023-02-03 17:11:20.583',NULL,0,0),
	(33,'go-admin/app/admin/apis/tools.Gen.GenMenuAndApi-fm','資料庫表生成到DB','/api/v1/gen/todb/:tableId','SYS','GET','2021-05-13 19:59:02.227','2023-02-03 17:11:20.583',NULL,0,0),
	(34,'go-admin/app/admin/apis/tools.(*SysTable).GetSysTablesTree-fm','關係表資料【代碼生成】','/api/v1/gen/tabletree','SYS','GET','2021-05-13 19:59:02.271','2023-02-03 17:11:20.583',NULL,0,0),
	(35,'go-admin/app/admin/apis/tools.Gen.Preview-fm','生成預覽通過id獲取','/api/v1/gen/preview/:tableId','SYS','GET','2021-05-13 19:59:02.315','2023-02-03 17:11:20.583',NULL,0,0),
	(36,'go-admin/app/admin/apis/tools.Gen.GenApiToFile-fm','生成api帶文件','/api/v1/gen/apitofile/:tableId','SYS','GET','2021-05-13 19:59:02.357','2023-02-03 17:11:20.583',NULL,0,0),
	(37,'go-admin/app/admin/apis.System.GenerateCaptchaHandler-fm','驗證碼獲取','/api/v1/getCaptcha','SYS','GET','2021-05-13 19:59:02.405','2023-02-03 17:11:20.583',NULL,0,0),
	(38,'go-admin/app/admin/apis.SysUser.GetInfo-fm','使用者訊息獲取','/api/v1/getinfo','SYS','GET','2021-05-13 19:59:02.447','2023-02-03 17:11:20.583',NULL,0,0),
	(39,'go-admin/app/admin/apis.SysMenu.GetPage-fm','選單列表','/api/v1/menu','BUS','GET','2021-05-13 19:59:02.497','2023-02-03 17:11:20.583',NULL,0,0),
	(40,'go-admin/app/admin/apis.SysMenu.GetMenuTreeSelect-fm','查詢選單下拉樹結構【廢棄】','/api/v1/menuTreeselect','SYS','GET','2021-05-13 19:59:02.542','2023-02-03 17:11:20.583',NULL,0,0),
	(41,'go-admin/app/admin/apis.SysMenu.Get-fm','選單通過id獲取','/api/v1/menu/:id','BUS','GET','2021-05-13 19:59:02.584','2023-02-03 17:11:20.583',NULL,0,0),
	(42,'go-admin/app/admin/apis.SysMenu.GetMenuRole-fm','角色選單【頂部左側選單】','/api/v1/menurole','SYS','GET','2021-05-13 19:59:02.630','2023-02-03 17:11:20.583',NULL,0,0),
	(43,'go-admin/app/admin/apis.SysMenu.GetMenuIDS-fm','獲取角色對應的選單id數組【廢棄】','/api/v1/menuids','SYS','GET','2021-05-13 19:59:02.675','2023-02-03 17:11:20.583',NULL,0,0),
	(44,'go-admin/app/admin/apis.SysRole.GetPage-fm','角色列表','/api/v1/role','BUS','GET','2021-05-13 19:59:02.720','2023-02-03 17:11:20.583',NULL,0,0),
	(45,'go-admin/app/admin/apis.SysMenu.GetMenuTreeSelect-fm','選單權限列表【角色配選單使用】','/api/v1/roleMenuTreeselect/:roleId','SYS','GET','2021-05-13 19:59:02.762','2023-02-03 17:11:20.583',NULL,0,0),
	(46,'go-admin/app/admin/apis.SysDept.GetDeptTreeRoleSelect-fm','角色部門結構樹【自定義資料權限】','/api/v1/roleDeptTreeselect/:roleId','SYS','GET','2021-05-13 19:59:02.809','2023-02-03 17:11:20.583',NULL,0,0),
	(47,'go-admin/app/admin/apis.SysRole.Get-fm','角色通過id獲取','/api/v1/role/:id','BUS','GET','2021-05-13 19:59:02.850','2023-02-03 17:11:20.583',NULL,0,0),
	(48,'github.com/go-admin-team/go-admin-core/sdk/pkg/jwtauth.(*GinJWTMiddleware).RefreshHandler-fm','刷新token','/api/v1/refresh_token','SYS','GET','2021-05-13 19:59:02.892','2023-02-03 17:11:20.583',NULL,0,0),
	(53,'go-admin/app/admin/apis.SysConfig.GetPage-fm','參數列表','/api/v1/config','BUS','GET','2021-05-13 19:59:03.116','2023-02-03 17:11:20.583',NULL,0,0),
	(54,'go-admin/app/admin/apis.SysConfig.Get-fm','參數通過id獲取','/api/v1/config/:id','BUS','GET','2021-05-13 19:59:03.157','2023-02-03 17:11:20.583',NULL,0,0),
	(55,'go-admin/app/admin/apis.SysConfig.GetSysConfigByKEYForService-fm','參數通過鍵名搜索【基礎默認設定】','/api/v1/configKey/:configKey','SYS','GET','2021-05-13 19:59:03.198','2023-02-03 17:11:20.583',NULL,0,0),
	(57,'go-admin/app/jobs/apis.SysJob.RemoveJobForService-fm','job移除','/api/v1/job/remove/:id','BUS','GET','2021-05-13 19:59:03.295','2023-02-03 17:11:20.583',NULL,0,0),
	(58,'go-admin/app/jobs/apis.SysJob.StartJobForService-fm','job啟動','/api/v1/job/start/:id','BUS','GET','2021-05-13 19:59:03.339','2023-02-03 17:11:20.583',NULL,0,0),
	(59,'go-admin/app/admin/apis.SysPost.GetPage-fm','職位列表','/api/v1/post','BUS','GET','2021-05-13 19:59:03.381','2023-02-03 17:11:20.583',NULL,0,0),
	(60,'go-admin/app/admin/apis.SysPost.Get-fm','職位通過id獲取','/api/v1/post/:id','BUS','GET','2021-05-13 19:59:03.433','2023-02-03 17:11:20.583',NULL,0,0),
	(62,'go-admin/app/admin/apis.SysConfig.GetSysConfigBySysApp-fm','系統前端參數','/api/v1/app-config','SYS','GET','2021-05-13 19:59:03.526','2023-02-03 17:11:20.583',NULL,0,0),
	(63,'go-admin/app/admin/apis.SysUser.GetProfile-fm','*使用者訊息獲取','/api/v1/user/profile','SYS','GET','2021-05-13 19:59:03.567','2023-02-03 17:11:20.583',NULL,0,0),
	(66,'github.com/go-admin-team/go-admin-core/sdk/pkg/ws.(*Manager).WsClient-fm','鏈接ws【定時任務log】','/ws/:id/:channel','BUS','GET','2021-05-13 19:59:03.705','2023-02-03 17:11:20.583',NULL,0,0),
	(67,'github.com/go-admin-team/go-admin-core/sdk/pkg/ws.(*Manager).UnWsClient-fm','退出ws【定時任務log】','/wslogout/:id/:channel','BUS','GET','2021-05-13 19:59:03.756','2023-02-03 17:11:20.583',NULL,0,0),
	(68,'go-admin/common/middleware/handler.Ping','*使用者基本訊息','/info','SYS','GET','2021-05-13 19:59:03.800','2023-02-03 17:11:20.583',NULL,0,0),
	(72,'go-admin/common/actions.CreateAction.func1','分類創建','/api/v1/syscategory','BUS','POST','2021-05-13 19:59:03.982','2023-02-03 17:11:20.583',NULL,0,0),
	(73,'go-admin/common/actions.CreateAction.func1','內容創建','/api/v1/syscontent','BUS','POST','2021-05-13 19:59:04.027','2023-02-03 17:11:20.583',NULL,0,0),
	(76,'go-admin/common/actions.CreateAction.func1','job創建','/api/v1/sysjob','BUS','POST','2021-05-13 19:59:04.164','2023-02-03 17:11:20.583',NULL,0,0),
	(80,'go-admin/app/admin/apis.SysDictData.Insert-fm','字典資料創建','/api/v1/dict/data','BUS','POST','2021-05-13 19:59:04.347','2023-02-03 17:11:20.583',NULL,0,0),
	(81,'go-admin/app/admin/apis.SysDictType.Insert-fm','字典類型創建','/api/v1/dict/type','BUS','POST','2021-05-13 19:59:04.391','2023-02-03 17:11:20.583',NULL,0,0),
	(82,'go-admin/app/admin/apis.SysDept.Insert-fm','部門創建','/api/v1/dept','BUS','POST','2021-05-13 19:59:04.435','2023-02-03 17:11:20.583',NULL,0,0),
	(85,'github.com/go-admin-team/go-admin-core/sdk/pkg/jwtauth.(*GinJWTMiddleware).LoginHandler-fm','*登錄','/api/v1/login','SYS','POST','2021-05-13 19:59:04.597','2023-02-03 17:11:20.583',NULL,0,0),
	(86,'go-admin/common/middleware/handler.LogOut','*退出','/api/v1/logout','SYS','POST','2021-05-13 19:59:04.642','2023-02-03 17:11:20.583',NULL,0,0),
	(87,'go-admin/app/admin/apis.SysConfig.Insert-fm','參數創建','/api/v1/config','BUS','POST','2021-05-13 19:59:04.685','2023-02-03 17:11:20.583',NULL,0,0),
	(88,'go-admin/app/admin/apis.SysMenu.Insert-fm','選單創建','/api/v1/menu','BUS','POST','2021-05-13 19:59:04.777','2023-02-03 17:11:20.583',NULL,0,0),
	(89,'go-admin/app/admin/apis.SysPost.Insert-fm','職位創建','/api/v1/post','BUS','POST','2021-05-13 19:59:04.886','2023-02-03 17:11:20.583',NULL,0,0),
	(90,'go-admin/app/admin/apis.SysRole.Insert-fm','角色創建','/api/v1/role','BUS','POST','2021-05-13 19:59:04.975','2023-02-03 17:11:20.583',NULL,0,0),
	(91,'go-admin/app/admin/apis.SysUser.InsetAvatar-fm','*使用者頭像編輯','/api/v1/user/avatar','SYS','POST','2021-05-13 19:59:05.058','2023-02-03 17:11:20.583',NULL,0,0),
	(92,'go-admin/app/admin/apis.SysApi.Update-fm','接口編輯','/api/v1/sys-api/:id','BUS','PUT','2021-05-13 19:59:05.122','2023-02-03 17:11:20.583',NULL,0,0),
	(95,'go-admin/common/actions.UpdateAction.func1','分類編輯','/api/v1/syscategory/:id','BUS','PUT','2021-05-13 19:59:05.255','2023-02-03 17:11:20.583',NULL,0,0),
	(96,'go-admin/common/actions.UpdateAction.func1','內容編輯','/api/v1/syscontent/:id','BUS','PUT','2021-05-13 19:59:05.299','2023-02-03 17:11:20.583',NULL,0,0),
	(97,'go-admin/common/actions.UpdateAction.func1','job編輯','/api/v1/sysjob','BUS','PUT','2021-05-13 19:59:05.343','2023-02-03 17:11:20.583',NULL,0,0),
	(101,'go-admin/app/admin/apis.SysDictData.Update-fm','字典資料編輯','/api/v1/dict/data/:dictCode','BUS','PUT','2021-05-13 19:59:05.519','2023-02-03 17:11:20.583',NULL,0,0),
	(102,'go-admin/app/admin/apis.SysDictType.Update-fm','字典類型編輯','/api/v1/dict/type/:id','BUS','PUT','2021-05-13 19:59:05.569','2023-02-03 17:11:20.583',NULL,0,0),
	(103,'go-admin/app/admin/apis.SysDept.Update-fm','部門編輯','/api/v1/dept/:id','BUS','PUT','2021-05-13 19:59:05.613','2023-02-03 17:11:20.583',NULL,0,0),
	(104,'go-admin/app/other/apis.SysFileDir.Update-fm','文件夾編輯','/api/v1/file-dir/:id','BUS','PUT','2021-05-13 19:59:05.662','2023-02-03 17:11:20.583',NULL,0,0),
	(105,'go-admin/app/other/apis.SysFileInfo.Update-fm','文件編輯','/api/v1/file-info/:id','BUS','PUT','2021-05-13 19:59:05.709','2023-02-03 17:11:20.583',NULL,0,0),
	(106,'go-admin/app/admin/apis.SysRole.Update-fm','角色編輯','/api/v1/role/:id','BUS','PUT','2021-05-13 19:59:05.752','2023-02-03 17:11:20.583',NULL,0,0),
	(107,'go-admin/app/admin/apis.SysRole.Update2DataScope-fm','角色資料權限修改','/api/v1/roledatascope','BUS','PUT','2021-05-13 19:59:05.803','2023-02-03 17:11:20.583',NULL,0,0),
	(108,'go-admin/app/admin/apis.SysConfig.Update-fm','參數編輯','/api/v1/config/:id','BUS','PUT','2021-05-13 19:59:05.848','2023-02-03 17:11:20.583',NULL,0,0),
	(109,'go-admin/app/admin/apis.SysMenu.Update-fm','編輯選單','/api/v1/menu/:id','BUS','PUT','2021-05-13 19:59:05.891','2023-02-03 17:11:20.583',NULL,0,0),
	(110,'go-admin/app/admin/apis.SysPost.Update-fm','職位編輯','/api/v1/post/:id','BUS','PUT','2021-05-13 19:59:05.934','2023-02-03 17:11:20.583',NULL,0,0),
	(111,'go-admin/app/admin/apis.SysUser.UpdatePwd-fm','*使用者修改密碼','/api/v1/user/pwd','SYS','PUT','2021-05-13 19:59:05.987','2023-02-03 17:11:20.583',NULL,0,0),
	(112,'go-admin/common/actions.DeleteAction.func1','分類刪除','/api/v1/syscategory','BUS','DELETE','2021-05-13 19:59:06.030','2023-02-03 17:11:20.583',NULL,0,0),
	(113,'go-admin/common/actions.DeleteAction.func1','內容刪除','/api/v1/syscontent','BUS','DELETE','2021-05-13 19:59:06.076','2023-02-03 17:11:20.583',NULL,0,0),
	(114,'go-admin/app/admin/apis.SysLoginLog.Delete-fm','登錄日誌刪除','/api/v1/sys-login-log','BUS','DELETE','2021-05-13 19:59:06.118','2023-02-03 17:11:20.583',NULL,0,0),
	(115,'go-admin/app/admin/apis.SysOperaLog.Delete-fm','操作日誌刪除','/api/v1/sys-opera-log','BUS','DELETE','2021-05-13 19:59:06.162','2023-02-03 17:11:20.583',NULL,0,0),
	(116,'go-admin/common/actions.DeleteAction.func1','job刪除','/api/v1/sysjob','BUS','DELETE','2021-05-13 19:59:06.206','2023-02-03 17:11:20.583',NULL,0,0),
	(117,'go-admin/app/other/apis.SysChinaAreaData.Delete-fm','行政區刪除','/api/v1/sys-area-data','BUS','DELETE','2021-05-13 19:59:06.249','2023-02-03 17:11:20.583',NULL,0,0),
	(120,'go-admin/app/admin/apis.SysDictData.Delete-fm','字典資料刪除','/api/v1/dict/data','BUS','DELETE','2021-05-13 19:59:06.387','2023-02-03 17:11:20.583',NULL,0,0),
	(121,'go-admin/app/admin/apis.SysDictType.Delete-fm','字典類型刪除','/api/v1/dict/type','BUS','DELETE','2021-05-13 19:59:06.432','2023-02-03 17:11:20.583',NULL,0,0),
	(122,'go-admin/app/admin/apis.SysDept.Delete-fm','部門刪除','/api/v1/dept/:id','BUS','DELETE','2021-05-13 19:59:06.475','2023-02-03 17:11:20.583',NULL,0,0),
	(123,'go-admin/app/other/apis.SysFileDir.Delete-fm','文件夾刪除','/api/v1/file-dir/:id','BUS','DELETE','2021-05-13 19:59:06.520','2023-02-03 17:11:20.583',NULL,0,0),
	(124,'go-admin/app/other/apis.SysFileInfo.Delete-fm','文件刪除','/api/v1/file-info/:id','BUS','DELETE','2021-05-13 19:59:06.566','2023-02-03 17:11:20.583',NULL,0,0),
	(125,'go-admin/app/admin/apis.SysConfig.Delete-fm','參數刪除','/api/v1/config','BUS','DELETE','2021-05-13 19:59:06.612','2023-02-03 17:11:20.583',NULL,0,0),
	(126,'go-admin/app/admin/apis.SysMenu.Delete-fm','刪除選單','/api/v1/menu','BUS','DELETE','2021-05-13 19:59:06.654','2023-02-03 17:11:20.583',NULL,0,0),
	(127,'go-admin/app/admin/apis.SysPost.Delete-fm','職位刪除','/api/v1/post/:id','BUS','DELETE','2021-05-13 19:59:06.702','2023-02-03 17:11:20.583',NULL,0,0),
	(128,'go-admin/app/admin/apis.SysRole.Delete-fm','角色刪除','/api/v1/role','BUS','DELETE','2021-05-13 19:59:06.746','2023-02-03 17:11:20.583',NULL,0,0),
	(131,'github.com/go-admin-team/go-admin-core/tools/transfer.Handler.func1','系統指標','/api/v1/metrics','SYS','GET','2021-05-17 22:13:55.933','2023-02-03 17:11:20.583',NULL,0,0),
	(132,'go-admin/app/other/router.registerMonitorRouter.func1','健康狀態','/api/v1/health','SYS','GET','2021-05-17 22:13:56.285','2023-02-03 17:11:20.583',NULL,0,0),
	(133,'go-admin/app/admin/apis.HelloWorld','項目默認接口','/','SYS','GET','2021-05-24 10:30:44.553','2023-02-03 17:11:20.583',NULL,0,0),
	(134,'go-admin/app/other/apis.ServerMonitor.ServerInfo-fm','服務器基本狀態','/api/v1/server-monitor','SYS','GET','2021-05-24 10:30:44.937','2023-02-03 17:11:20.583',NULL,0,0),
	(135,'go-admin/app/admin/apis.SysApi.GetPage-fm','接口列表','/api/v1/sys-api','BUS','GET','2021-05-24 11:37:53.303','2023-02-03 17:11:20.583',NULL,0,0),
	(136,'go-admin/app/admin/apis.SysApi.Get-fm','接口通過id獲取','/api/v1/sys-api/:id','BUS','GET','2021-05-24 11:37:53.359','2023-02-03 17:11:20.583',NULL,0,0),
	(137,'go-admin/app/admin/apis.SysLoginLog.GetPage-fm','登錄日誌列表','/api/v1/sys-login-log','BUS','GET','2021-05-24 11:47:30.397','2023-02-03 17:11:20.583',NULL,0,0),
	(138,'go-admin/app/other/apis.File.UploadFile-fm','文件上傳','/api/v1/public/uploadFile','SYS','POST','2021-05-25 19:16:18.493','2023-02-03 17:11:20.583',NULL,0,0),
	(139,'go-admin/app/admin/apis.SysConfig.Update2Set-fm','參數訊息修改【參數設定】','/api/v1/set-config','BUS','PUT','2021-05-27 09:45:14.853','2023-02-03 17:11:20.583',NULL,0,0),
	(140,'go-admin/app/admin/apis.SysConfig.Get2Set-fm','參數獲取全部【設定使用】','/api/v1/set-config','BUS','GET','2021-05-27 11:54:14.384','2023-02-03 17:11:20.583',NULL,0,0),
	(141,'go-admin/app/admin/apis.SysUser.GetPage-fm','管理員列表','/api/v1/sys-user','BUS','GET','2021-06-13 19:24:57.111','2023-02-03 17:11:20.583',NULL,0,0),
	(142,'go-admin/app/admin/apis.SysUser.Get-fm','管理員通過id獲取','/api/v1/sys-user/:id','BUS','GET','2021-06-13 19:24:57.188','2023-02-03 17:11:20.583',NULL,0,0),
	(143,'go-admin/app/admin/apis/tools.(*SysTable).GetSysTablesInfo-fm','','/api/v1/sys/tables/info','','GET','2021-06-13 19:24:57.437','2023-02-03 17:11:20.583',NULL,0,0),
	(144,'go-admin/app/admin/apis/tools.(*SysTable).GetSysTables-fm','','/api/v1/sys/tables/info/:tableId','','GET','2021-06-13 19:24:57.510','2023-02-03 17:11:20.583',NULL,0,0),
	(145,'go-admin/app/admin/apis/tools.(*SysTable).GetSysTableList-fm','','/api/v1/sys/tables/page','','GET','2021-06-13 19:24:57.582','2023-02-03 17:11:20.583',NULL,0,0),
	(146,'github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1','','/static/*filepath','','GET','2021-06-13 19:24:59.641','2023-02-03 17:11:20.583',NULL,0,0),
	(147,'github.com/swaggo/gin-swagger.CustomWrapHandler.func1','','/swagger/*any','','GET','2021-06-13 19:24:59.713','2023-02-03 17:11:20.583',NULL,0,0),
	(148,'github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1','','/form-generator/*filepath','','GET','2021-06-13 19:24:59.914','2023-02-03 17:11:20.583',NULL,0,0),
	(149,'go-admin/app/admin/apis/tools.(*SysTable).InsertSysTable-fm','','/api/v1/sys/tables/info','','POST','2021-06-13 19:25:00.163','2023-02-03 17:11:20.583',NULL,0,0),
	(150,'go-admin/app/admin/apis.SysUser.Insert-fm','管理員創建','/api/v1/sys-user','BUS','POST','2021-06-13 19:25:00.233','2023-02-03 17:11:20.583',NULL,0,0),
	(151,'go-admin/app/admin/apis.SysUser.Update-fm','管理員編輯','/api/v1/sys-user','BUS','PUT','2021-06-13 19:25:00.986','2023-02-03 17:11:20.583',NULL,0,0),
	(152,'go-admin/app/admin/apis/tools.(*SysTable).UpdateSysTable-fm','','/api/v1/sys/tables/info','','PUT','2021-06-13 19:25:01.149','2023-02-03 17:11:20.583',NULL,0,0),
	(153,'go-admin/app/admin/apis.SysRole.Update2Status-fm','','/api/v1/role-status','','PUT','2021-06-13 19:25:01.446','2023-02-03 17:11:20.583',NULL,0,0),
	(154,'go-admin/app/admin/apis.SysUser.ResetPwd-fm','','/api/v1/user/pwd/reset','','PUT','2021-06-13 19:25:01.601','2023-02-03 17:11:20.583',NULL,0,0),
	(155,'go-admin/app/admin/apis.SysUser.UpdateStatus-fm','','/api/v1/user/status','','PUT','2021-06-13 19:25:01.671','2023-02-03 17:11:20.583',NULL,0,0),
	(156,'go-admin/app/admin/apis.SysUser.Delete-fm','管理員刪除','/api/v1/sys-user','BUS','DELETE','2021-06-13 19:25:02.043','2023-02-03 17:11:20.583',NULL,0,0),
	(157,'go-admin/app/admin/apis/tools.(*SysTable).DeleteSysTables-fm','','/api/v1/sys/tables/info/:tableId','','DELETE','2021-06-13 19:25:02.283','2023-02-03 17:11:20.583',NULL,0,0),
	(158,'github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1','','/static/*filepath','','HEAD','2021-06-13 19:25:02.734','2023-02-03 17:11:20.583',NULL,0,0),
	(159,'github.com/gin-gonic/gin.(*RouterGroup).createStaticHandler.func1','','/form-generator/*filepath','','HEAD','2021-06-13 19:25:02.808','2023-02-03 17:11:20.583',NULL,0,0),
	(160,'go-admin/app/admin/apis.System.GenerateCaptchaHandler-fm','','/api/v1/captcha','','GET','2023-02-03 15:38:30.089','2023-02-03 17:11:20.583',NULL,0,0);

/*!40000 ALTER TABLE `sys_api` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_casbin_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_casbin_rule`;

CREATE TABLE `sys_casbin_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ptype` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v0` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v6` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `v7` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_casbin_rule` (`ptype`,`v0`,`v1`,`v2`,`v3`,`v4`,`v5`,`v6`,`v7`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table sys_columns
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_columns`;

CREATE TABLE `sys_columns` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_id` bigint(20) DEFAULT NULL,
  `column_name` varchar(128) DEFAULT NULL,
  `column_comment` varchar(128) DEFAULT NULL,
  `column_type` varchar(128) DEFAULT NULL,
  `go_type` varchar(128) DEFAULT NULL,
  `go_field` varchar(128) DEFAULT NULL,
  `json_field` varchar(128) DEFAULT NULL,
  `is_pk` varchar(4) DEFAULT NULL,
  `is_increment` varchar(4) DEFAULT NULL,
  `is_required` varchar(4) DEFAULT NULL,
  `is_insert` varchar(4) DEFAULT NULL,
  `is_edit` varchar(4) DEFAULT NULL,
  `is_list` varchar(4) DEFAULT NULL,
  `is_query` varchar(4) DEFAULT NULL,
  `query_type` varchar(128) DEFAULT NULL,
  `html_type` varchar(128) DEFAULT NULL,
  `dict_type` varchar(128) DEFAULT NULL,
  `sort` bigint(20) DEFAULT NULL,
  `list` varchar(1) DEFAULT NULL,
  `pk` tinyint(1) DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `super_column` tinyint(1) DEFAULT NULL,
  `usable_column` tinyint(1) DEFAULT NULL,
  `increment` tinyint(1) DEFAULT NULL,
  `insert` tinyint(1) DEFAULT NULL,
  `edit` tinyint(1) DEFAULT NULL,
  `query` tinyint(1) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `fk_table_name` longtext DEFAULT NULL,
  `fk_table_name_class` longtext DEFAULT NULL,
  `fk_table_name_package` longtext DEFAULT NULL,
  `fk_label_id` longtext DEFAULT NULL,
  `fk_label_name` varchar(255) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`column_id`),
  KEY `idx_sys_columns_deleted_at` (`deleted_at`),
  KEY `idx_sys_columns_create_by` (`create_by`),
  KEY `idx_sys_columns_update_by` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_columns` WRITE;
/*!40000 ALTER TABLE `sys_columns` DISABLE KEYS */;

INSERT INTO `sys_columns` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `go_type`, `go_field`, `json_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `list`, `pk`, `required`, `super_column`, `usable_column`, `increment`, `insert`, `edit`, `query`, `remark`, `fk_table_name`, `fk_table_name_class`, `fk_table_name_package`, `fk_label_id`, `fk_label_name`, `created_at`, `updated_at`, `deleted_at`, `create_by`, `update_by`)
VALUES
	(1,1,'id','id','int(11)','int','Id','id','1','','1','1','','','','EQ','input','',1,'',1,1,0,0,0,1,0,0,'','','','','','','2023-02-03 22:35:11.812','2023-02-03 22:35:11.812',NULL,0,0),
	(2,1,'name','name','varchar(100)','string','Name','name','0','','1','1','','1','1','EQ','input','sys_normal_disable',2,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:35:11.821','2023-02-03 22:51:00.232',NULL,0,0),
	(3,1,'label','label','varchar(100)','string','Label','label','0','','1','1','','1','','EQ','input','',3,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:35:11.831','2023-02-03 22:51:00.249',NULL,0,0),
	(4,1,'created_at','created_at','timestamp','time.Time','CreatedAt','createdAt','0','','0','1','','','','EQ','datetime','',4,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:35:11.838','2023-02-03 22:35:11.838',NULL,0,0),
	(5,1,'deleted_at','deleted_at','timestamp','time.Time','DeletedAt','deletedAt','0','','0','1','','','','EQ','datetime','',5,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:35:11.844','2023-02-03 22:35:11.844',NULL,0,0),
	(6,2,'id','id','int(11)','int','Id','id','1','','1','1','','','','EQ','input','',1,'',1,1,0,0,0,1,0,0,'','','','','','','2023-02-03 22:53:57.659','2023-02-03 22:53:57.659',NULL,0,0),
	(7,2,'name','name','varchar(100)','string','Name','name','0','','0','1','','1','1','EQ','input','',2,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:53:57.672','2023-02-03 22:54:14.884',NULL,0,0),
	(8,2,'label','label','varchar(100)','string','Label','label','0','','0','1','','1','','EQ','input','',3,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:53:57.680','2023-02-03 22:54:14.901',NULL,0,0),
	(9,2,'created_at','created_at','timestamp','time.Time','CreatedAt','createdAt','0','','0','1','','','','EQ','datetime','',4,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:53:57.686','2023-02-03 22:53:57.686',NULL,0,0),
	(10,2,'deleted_at','deleted_at','timestamp','time.Time','DeletedAt','deletedAt','0','','0','1','','','','EQ','datetime','',5,'',0,0,0,0,0,1,0,0,'','','','','','','2023-02-03 22:53:57.692','2023-02-03 22:53:57.692',NULL,0,0);

/*!40000 ALTER TABLE `sys_columns` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主鍵編碼',
  `config_name` varchar(128) DEFAULT NULL COMMENT 'ConfigName',
  `config_key` varchar(128) DEFAULT NULL COMMENT 'ConfigKey',
  `config_value` varchar(255) DEFAULT NULL COMMENT 'ConfigValue',
  `config_type` varchar(64) DEFAULT NULL COMMENT 'ConfigType',
  `is_frontend` varchar(64) DEFAULT NULL COMMENT '是否前台',
  `remark` varchar(128) DEFAULT NULL COMMENT 'Remark',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`id`),
  KEY `idx_sys_config_create_by` (`create_by`),
  KEY `idx_sys_config_update_by` (`update_by`),
  KEY `idx_sys_config_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;

INSERT INTO `sys_config` (`id`, `config_name`, `config_key`, `config_value`, `config_type`, `is_frontend`, `remark`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'主題樣式','sys_index_skinName','skin-blue','Y','0','主框架頁-默認主題樣式名稱:藍色 skin-blue、綠色 skin-green、紫色 skin-purple、紅色 skin-red、黃色 skin-yellow',1,1,'2021-05-13 19:56:37.913','2023-02-06 16:13:41.447',NULL),
	(2,'初始密碼','sys_user_initPassword','123456','Y','0','使用者管理-帳號初始密碼:123456',1,1,'2021-05-13 19:56:37.913','2021-05-13 19:56:37.913',NULL),
	(3,'側欄主題','sys_index_sideTheme','theme-dark','Y','0','主框架頁-側邊欄主題:深色主題theme-dark，淺色主題theme-light',1,1,'2021-05-13 19:56:37.913','2021-05-13 19:56:37.913',NULL),
	(4,'系統名稱','sys_app_name','業績管理系統','Y','1','',1,0,'2021-03-17 08:52:06.067','2023-02-06 15:54:29.844',NULL),
	(5,'系統logo','sys_app_logo','http://localhost:8000/static/uploadfile/d9407063-2d3a-4fa4-a6c9-2182313b0773.png','Y','1','',1,0,'2021-03-17 08:53:19.462','2023-02-06 16:13:30.267',NULL);

/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `dept_path` varchar(255) DEFAULT NULL,
  `dept_name` varchar(128) DEFAULT NULL,
  `sort` tinyint(4) DEFAULT NULL,
  `leader` varchar(128) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`dept_id`),
  KEY `idx_sys_dept_create_by` (`create_by`),
  KEY `idx_sys_dept_update_by` (`update_by`),
  KEY `idx_sys_dept_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;

INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `dept_path`, `dept_name`, `sort`, `leader`, `phone`, `email`, `status`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,0,'/0/1/','蓋亞',0,'aituo','13782218188','atuo@aituo.com',2,1,1,'2021-05-13 19:56:37.913','2021-06-05 17:06:44.960',NULL),
	(7,1,'/0/1/7/','研發部',1,'aituo','13782218188','atuo@aituo.com',2,1,1,'2021-05-13 19:56:37.913','2021-06-16 21:35:00.109',NULL),
	(8,1,'/0/1/8/','維運部',2,'aituo','13782218188','atuo@aituo.com',2,1,1,'2021-05-13 19:56:37.913','2021-06-16 21:41:39.747',NULL),
	(9,1,'/0/1/9/','業務部',3,'修哥','','',2,1,1,'2021-05-13 19:56:37.913','2023-02-06 15:56:17.262',NULL),
	(10,1,'/0/1/10/','人事部',4,'aituo','13782218188','atuo@aituo.com',2,1,1,'2021-05-13 19:56:37.913','2023-02-03 15:02:20.080',NULL),
	(11,7,'/0/1/7/11/','專案軟體組',10,'Jenny','','',2,0,0,'2023-02-03 21:20:28.162','2023-02-03 21:20:28.174',NULL),
	(12,1,'/0/1/12/','業務部門',10,'修哥','','',2,0,0,'2023-02-06 15:55:35.071','2023-02-06 15:55:35.078','2023-02-06 15:56:02.332'),
	(13,9,'/0/1/9/13/','處級',10,'修哥','','',2,0,0,'2023-02-06 15:56:47.553','2023-02-06 15:56:47.562',NULL),
	(14,13,'/0/1/9/13/14/','部級',10,'修哥','','',2,0,0,'2023-02-06 15:57:39.322','2023-02-06 15:57:39.332',NULL),
	(15,14,'/0/1/9/13/14/15/','組長',10,'各組長','','',2,0,0,'2023-02-06 15:58:17.185','2023-02-06 15:58:17.192',NULL),
	(16,15,'/0/1/9/13/14/15/16/','組員',10,'各組長','','',2,0,0,'2023-02-06 15:58:45.668','2023-02-06 15:58:45.679',NULL);

/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_dict_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict_data`;

CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT,
  `dict_sort` bigint(20) DEFAULT NULL,
  `dict_label` varchar(128) DEFAULT NULL,
  `dict_value` varchar(255) DEFAULT NULL,
  `dict_type` varchar(64) DEFAULT NULL,
  `css_class` varchar(128) DEFAULT NULL,
  `list_class` varchar(128) DEFAULT NULL,
  `is_default` varchar(8) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `default` varchar(8) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`dict_code`),
  KEY `idx_sys_dict_data_create_by` (`create_by`),
  KEY `idx_sys_dict_data_update_by` (`update_by`),
  KEY `idx_sys_dict_data_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;

INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `default`, `remark`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,0,'正常','2','sys_normal_disable','','','',2,'','系統正常',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:40.168',NULL),
	(2,0,'停用','1','sys_normal_disable','','','',2,'','系統停用',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(3,0,'男','0','sys_user_sex','','','',2,'','性別男',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(4,0,'女','1','sys_user_sex','','','',2,'','性別女',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(5,0,'未知','2','sys_user_sex','','','',2,'','性別未知',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(6,0,'顯示','0','sys_show_hide','','','',2,'','顯示選單',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(7,0,'隱藏','1','sys_show_hide','','','',2,'','隱藏選單',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(8,0,'是','Y','sys_yes_no','','','',2,'','系統默認是',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(9,0,'否','N','sys_yes_no','','','',2,'','系統默認否',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(10,0,'正常','2','sys_job_status','','','',2,'','正常狀態',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(11,0,'停用','1','sys_job_status','','','',2,'','停用狀態',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(12,0,'默認','DEFAULT','sys_job_group','','','',2,'','默認分組',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(13,0,'系統','SYSTEM','sys_job_group','','','',2,'','系統分組',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(14,0,'通知','1','sys_notice_type','','','',2,'','通知',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(15,0,'公告','2','sys_notice_type','','','',2,'','公告',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(16,0,'正常','2','sys_common_status','','','',2,'','正常狀態',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(17,0,'關閉','1','sys_common_status','','','',2,'','關閉狀態',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(18,0,'新增','1','sys_oper_type','','','',2,'','新增操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(19,0,'修改','2','sys_oper_type','','','',2,'','修改操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(20,0,'刪除','3','sys_oper_type','','','',2,'','刪除操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(21,0,'授權','4','sys_oper_type','','','',2,'','授權操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(22,0,'導出','5','sys_oper_type','','','',2,'','導出操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(23,0,'導入','6','sys_oper_type','','','',2,'','導入操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(24,0,'強退','7','sys_oper_type','','','',2,'','強退操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(25,0,'生成代碼','8','sys_oper_type','','','',2,'','生成操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(26,0,'清空資料','9','sys_oper_type','','','',2,'','清空操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(27,0,'成功','0','sys_notice_status','','','',2,'','成功狀態',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(28,0,'失敗','1','sys_notice_status','','','',2,'','失敗狀態',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(29,0,'登錄','10','sys_oper_type','','','',2,'','登錄操作',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(30,0,'退出','11','sys_oper_type','','','',2,'','',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(31,0,'獲取驗證碼','12','sys_oper_type','','','',2,'','獲取驗證碼',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(32,0,'正常','1','sys_content_status','','','',1,'','',1,1,'2021-05-13 19:56:40.845','2021-05-13 19:56:40.845',NULL),
	(33,1,'禁用','2','sys_content_status','','','',1,'','',1,1,'2021-05-13 19:56:40.845','2021-05-13 19:56:40.845',NULL);

/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_dict_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict_type`;

CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dict_name` varchar(128) DEFAULT NULL,
  `dict_type` varchar(128) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`dict_id`),
  KEY `idx_sys_dict_type_update_by` (`update_by`),
  KEY `idx_sys_dict_type_deleted_at` (`deleted_at`),
  KEY `idx_sys_dict_type_create_by` (`create_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;

INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `remark`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'系統開關','sys_normal_disable',2,'系統開關列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(2,'使用者性別','sys_user_sex',2,'使用者性別列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(3,'選單狀態','sys_show_hide',2,'選單狀態列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(4,'系統是否','sys_yes_no',2,'系統是否列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(5,'任務狀態','sys_job_status',2,'任務狀態列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(6,'任務分組','sys_job_group',2,'任務分組列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(7,'通知類型','sys_notice_type',2,'通知類型列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(8,'系統狀態','sys_common_status',2,'登錄狀態列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(9,'操作類型','sys_oper_type',2,'操作類型列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(10,'通知狀態','sys_notice_status',2,'通知狀態列表',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:37.914',NULL),
	(11,'內容狀態','sys_content_status',2,'',1,1,'2021-05-13 19:56:40.813','2021-05-13 19:56:40.813',NULL);

/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_job
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_job`;

CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) DEFAULT NULL,
  `job_group` varchar(255) DEFAULT NULL,
  `job_type` tinyint(4) DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `invoke_target` varchar(255) DEFAULT NULL,
  `args` varchar(255) DEFAULT NULL,
  `misfire_policy` bigint(20) DEFAULT NULL,
  `concurrent` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `entry_id` smallint(6) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`job_id`),
  KEY `idx_sys_job_deleted_at` (`deleted_at`),
  KEY `idx_sys_job_create_by` (`create_by`),
  KEY `idx_sys_job_update_by` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;

INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `job_type`, `cron_expression`, `invoke_target`, `args`, `misfire_policy`, `concurrent`, `status`, `entry_id`, `created_at`, `updated_at`, `deleted_at`, `create_by`, `update_by`)
VALUES
	(1,'接口測試','DEFAULT',1,'0/5 * * * * ','http://localhost:8000','',1,1,1,0,'2021-05-13 19:56:37.914','2021-06-14 20:59:55.417',NULL,1,1),
	(2,'函數測試','DEFAULT',2,'0/5 * * * * ','ExamplesOne','參數',1,1,1,0,'2021-05-13 19:56:37.914','2021-05-31 23:55:37.221',NULL,1,1);

/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_login_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_login_log`;

CREATE TABLE `sys_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主鍵編碼',
  `username` varchar(128) DEFAULT NULL COMMENT '使用者名',
  `status` varchar(4) DEFAULT NULL COMMENT '狀態',
  `ipaddr` varchar(255) DEFAULT NULL COMMENT 'ip地址',
  `login_location` varchar(255) DEFAULT NULL COMMENT '歸屬地',
  `browser` varchar(255) DEFAULT NULL COMMENT '瀏覽器',
  `os` varchar(255) DEFAULT NULL COMMENT '系統',
  `platform` varchar(255) DEFAULT NULL COMMENT '平台',
  `login_time` timestamp NULL DEFAULT NULL COMMENT '登錄時間',
  `remark` varchar(255) DEFAULT NULL COMMENT '備註',
  `msg` varchar(255) DEFAULT NULL COMMENT '訊息',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`),
  KEY `idx_sys_login_log_create_by` (`create_by`),
  KEY `idx_sys_login_log_update_by` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(128) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `icon` varchar(128) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `paths` varchar(128) DEFAULT NULL,
  `menu_type` varchar(1) DEFAULT NULL,
  `action` varchar(16) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `parent_id` smallint(6) DEFAULT NULL,
  `no_cache` tinyint(1) DEFAULT NULL,
  `breadcrumb` varchar(255) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `sort` tinyint(4) DEFAULT NULL,
  `visible` varchar(1) DEFAULT NULL,
  `is_frame` varchar(1) DEFAULT '0',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`menu_id`),
  KEY `idx_sys_menu_create_by` (`create_by`),
  KEY `idx_sys_menu_update_by` (`update_by`),
  KEY `idx_sys_menu_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `title`, `icon`, `path`, `paths`, `menu_type`, `action`, `permission`, `parent_id`, `no_cache`, `breadcrumb`, `component`, `sort`, `visible`, `is_frame`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(2,'Admin','系統管理','api-server','/admin','/0/2','M','無','',0,1,'','Layout',10,'0','1',0,1,'2021-05-20 21:58:45.679','2023-02-03 14:32:11.420',NULL),
	(3,'SysUserManage','使用者管理','user','/admin/sys-user','/0/2/3','C','無','admin:sysUser:list',2,0,'','/admin/sys-user/index',10,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.429',NULL),
	(43,'','新增管理員','app-group-fill','','/0/2/3/43','F','POST','admin:sysUser:add',3,0,'','',10,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.460',NULL),
	(44,'','查詢管理員','app-group-fill','','/0/2/3/44','F','GET','admin:sysUser:query',3,0,'','',40,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.462',NULL),
	(45,'','修改管理員','app-group-fill','','/0/2/3/45','F','PUT','admin:sysUser:edit',3,0,'','',30,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.464',NULL),
	(46,'','刪除管理員','app-group-fill','','/0/2/3/46','F','DELETE','admin:sysUser:remove',3,0,'','',20,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.467',NULL),
	(51,'SysMenuManage','選單管理','tree-table','/admin/sys-menu','/0/2/51','C','無','admin:sysMenu:list',2,1,'','/admin/sys-menu/index',30,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.432',NULL),
	(52,'SysRoleManage','角色管理','peoples','/admin/sys-role','/0/2/52','C','無','admin:sysRole:list',2,1,'','/admin/sys-role/index',20,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.435',NULL),
	(56,'SysDeptManage','部門管理','tree','/admin/sys-dept','/0/2/56','C','無','admin:sysDept:list',2,0,'','/admin/sys-dept/index',40,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 16:49:36.999',NULL),
	(57,'SysPostManage','職位管理','pass','/admin/sys-post','/0/2/57','C','無','admin:sysPost:list',2,0,'','/admin/sys-post/index',50,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.441',NULL),
	(58,'Dict','字典管理','education','/admin/dict','/0/2/58','C','無','admin:sysDictType:list',2,0,'','/admin/dict/index',60,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.443',NULL),
	(59,'SysDictDataManage','字典資料','education','/admin/dict/data/:dictId','/0/2/59','C','無','admin:sysDictData:list',2,0,'','/admin/dict/data',100,'1','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.446',NULL),
	(60,'Tools','開發工具','dev-tools','/dev-tools','/0/60','M','無','',0,0,'','Layout',40,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.423',NULL),
	(61,'Swagger','系統接口','guide','/dev-tools/swagger','/0/60/61','C','無','',60,0,'','/dev-tools/swagger/index',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.533',NULL),
	(62,'SysConfigManage','參數管理','swagger','/admin/sys-config','/0/2/62','C','無','admin:sysConfig:list',2,0,'','/admin/sys-config/index',70,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.449',NULL),
	(211,'Log','日誌管理','log','/log','/0/2/211','M','','',2,0,'','/log/index',80,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.451',NULL),
	(212,'SysLoginLogManage','登錄日誌','logininfor','/admin/sys-login-log','/0/2/211/212','C','','admin:sysLoginLog:list',211,0,'','/admin/sys-login-log/index',1,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.557',NULL),
	(216,'OperLog','操作日誌','skill','/admin/sys-oper-log','/0/2/211/216','C','','admin:sysOperLog:list',211,0,'','/admin/sys-oper-log/index',1,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 14:32:11.560',NULL),
	(220,'','新增選單','app-group-fill','','/0/2/51/220','F','','admin:sysMenu:add',51,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.469',NULL),
	(221,'','修改選單','app-group-fill','','/0/2/51/221','F','','admin:sysMenu:edit',51,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.472',NULL),
	(222,'','查詢選單','app-group-fill','','/0/2/51/222','F','','admin:sysMenu:query',51,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.475',NULL),
	(223,'','刪除選單','app-group-fill','','/0/2/51/223','F','','admin:sysMenu:remove',51,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.478',NULL),
	(224,'','新增角色','app-group-fill','','/0/2/52/224','F','','admin:sysRole:add',52,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.481',NULL),
	(225,'','查詢角色','app-group-fill','','/0/2/52/225','F','','admin:sysRole:query',52,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.483',NULL),
	(226,'','修改角色','app-group-fill','','/0/2/52/226','F','','admin:sysRole:update',52,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.486',NULL),
	(227,'','刪除角色','app-group-fill','','/0/2/52/227','F','','admin:sysRole:remove',52,0,'','',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.488',NULL),
	(228,'','查詢部門','app-group-fill','','/0/2/56/228','F','','admin:sysDept:query',56,0,'','',40,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 16:49:36.999',NULL),
	(229,'','新增部門','app-group-fill','','/0/2/56/229','F','','admin:sysDept:add',56,0,'','',10,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 16:49:36.999',NULL),
	(230,'','修改部門','app-group-fill','','/0/2/56/230','F','','admin:sysDept:edit',56,0,'','',30,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 16:49:36.999',NULL),
	(231,'','刪除部門','app-group-fill','','/0/2/56/231','F','','admin:sysDept:remove',56,0,'','',20,'0','1',0,1,'2021-05-20 22:08:44.526','2023-02-03 16:49:36.999',NULL),
	(232,'','查詢職位','app-group-fill','','/0/2/57/232','F','','admin:sysPost:query',57,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.502',NULL),
	(233,'','新增職位','app-group-fill','','/0/2/57/233','F','','admin:sysPost:add',57,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.504',NULL),
	(234,'','修改職位','app-group-fill','','/0/2/57/234','F','','admin:sysPost:edit',57,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.507',NULL),
	(235,'','刪除職位','app-group-fill','','/0/2/57/235','F','','admin:sysPost:remove',57,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.509',NULL),
	(236,'','查詢字典','app-group-fill','','/0/2/58/236','F','','admin:sysDictType:query',58,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.512',NULL),
	(237,'','新增類型','app-group-fill','','/0/2/58/237','F','','admin:sysDictType:add',58,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.514',NULL),
	(238,'','修改類型','app-group-fill','','/0/2/58/238','F','','admin:sysDictType:edit',58,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.517',NULL),
	(239,'','刪除類型','app-group-fill','','/0/2/58/239','F','','system:sysdicttype:remove',58,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.520',NULL),
	(240,'','查詢資料','app-group-fill','','/0/2/59/240','F','','admin:sysDictData:query',59,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.523',NULL),
	(241,'','新增資料','app-group-fill','','/0/2/59/241','F','','admin:sysDictData:add',59,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.525',NULL),
	(242,'','修改資料','app-group-fill','','/0/2/59/242','F','','admin:sysDictData:edit',59,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.527',NULL),
	(243,'','刪除資料','app-group-fill','','/0/2/59/243','F','','admin:sysDictData:remove',59,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.530',NULL),
	(244,'','查詢參數','app-group-fill','','/0/2/62/244','F','','admin:sysConfig:query',62,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.546',NULL),
	(245,'','新增參數','app-group-fill','','/0/2/62/245','F','','admin:sysConfig:add',62,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.549',NULL),
	(246,'','修改參數','app-group-fill','','/0/2/62/246','F','','admin:sysConfig:edit',62,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.552',NULL),
	(247,'','刪除參數','app-group-fill','','/0/2/62/247','F','','admin:sysConfig:remove',62,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.554',NULL),
	(248,'','查詢登錄日誌','app-group-fill','','/0/2/211/212/248','F','','admin:sysLoginLog:query',212,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.564',NULL),
	(249,'','刪除登錄日誌','app-group-fill','','/0/2/211/212/249','F','','admin:sysLoginLog:remove',212,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.566',NULL),
	(250,'','查詢操作日誌','app-group-fill','','/0/2/211/216/250','F','','admin:sysOperLog:query',216,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.568',NULL),
	(251,'','刪除操作日誌','app-group-fill','','/0/2/211/216/251','F','','admin:sysOperLog:remove',216,0,'','',0,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.571',NULL),
	(261,'Gen','代碼生成','code','/dev-tools/gen','/0/60/261','C','','',60,0,'','/dev-tools/gen/index',2,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.536',NULL),
	(262,'EditTable','代碼生成修改','build','/dev-tools/editTable','/0/60/262','C','','',60,0,'','/dev-tools/gen/editTable',100,'1','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.540',NULL),
	(264,'Build','表單構建','build','/dev-tools/build','/0/60/264','C','','',60,0,'','/dev-tools/build/index',1,'0','1',1,1,'2020-04-11 15:52:48.000','2023-02-03 14:32:11.543',NULL),
	(269,'ServerMonitor','服務監控','druid','/sys-tools/monitor','/0/537/269','C','','sysTools:serverMonitor:list',537,0,'','/sys-tools/monitor',0,'0','1',1,1,'2020-04-14 00:28:19.000','2023-02-03 14:32:11.596',NULL),
	(459,'Schedule','定時任務','time-range','/schedule','/0/459','M','無','',0,0,'','Layout',20,'0','1',1,1,'2020-08-03 09:17:37.000','2023-02-03 14:32:11.424',NULL),
	(460,'ScheduleManage','Schedule','job','/schedule/manage','/0/459/460','C','無','job:sysJob:list',459,0,'','/schedule/index',0,'0','1',1,1,'2020-08-03 09:17:37.000','2023-02-03 14:32:11.574',NULL),
	(461,'sys_job','分頁獲取定時任務','app-group-fill','','/0/459/460/461','F','無','job:sysJob:query',460,0,'','',0,'0','1',1,1,'2020-08-03 09:17:37.000','2023-02-03 14:32:11.578',NULL),
	(462,'sys_job','創建定時任務','app-group-fill','','/0/459/460/462','F','無','job:sysJob:add',460,0,'','',0,'0','1',1,1,'2020-08-03 09:17:37.000','2023-02-03 14:32:11.581',NULL),
	(463,'sys_job','修改定時任務','app-group-fill','','/0/459/460/463','F','無','job:sysJob:edit',460,0,'','',0,'0','1',1,1,'2020-08-03 09:17:37.000','2023-02-03 14:32:11.584',NULL),
	(464,'sys_job','刪除定時任務','app-group-fill','','/0/459/460/464','F','無','job:sysJob:remove',460,0,'','',0,'0','1',1,1,'2020-08-03 09:17:37.000','2023-02-03 14:32:11.587',NULL),
	(471,'JobLog','日誌','bug','/schedule/log','/0/459/471','C','','',459,0,'','/schedule/log',0,'1','1',1,1,'2020-08-05 21:24:46.000','2023-02-03 14:32:11.576',NULL),
	(528,'SysApiManage','接口管理','api-doc','/admin/sys-api','/0/2/528','C','無','admin:sysApi:list',2,0,'','/admin/sys-api/index',0,'0','0',0,1,'2021-05-20 22:08:44.526','2023-02-03 17:11:20.578',NULL),
	(529,'','查詢接口','app-group-fill','','/0/2/528/529','F','無','admin:sysApi:query',528,0,'','',40,'0','0',0,1,'2021-05-20 22:08:44.526','2023-02-03 17:11:20.578',NULL),
	(531,'','修改接口','app-group-fill','','/0/2/528/531','F','無','admin:sysApi:edit',528,0,'','',30,'0','0',0,1,'2021-05-20 22:08:44.526','2023-02-03 17:11:20.578',NULL),
	(537,'SysTools','系統工具','system-tools','/sys-tools','/0/537','M','','',0,0,'','Layout',30,'0','1',1,1,'2021-05-21 11:13:32.166','2023-02-03 14:32:11.426',NULL),
	(540,'SysConfigSet','參數設置','system-tools','/admin/sys-config/set','/0/2/540','C','','admin:sysConfigSet:list',2,0,'','/admin/sys-config/set',0,'0','1',1,1,'2021-05-25 16:06:52.560','2023-02-03 14:32:11.457',NULL),
	(542,'','修改','upload','','/0/2/540/542','F','','admin:sysConfigSet:update',540,0,'','',0,'0','1',1,1,'2021-06-13 11:45:48.670','2023-02-03 14:32:11.598',NULL),
	(543,'','文章','pass','/article','/0/543','M','無','',0,0,'','Layout',0,'1','0',1,1,'2023-02-03 15:20:56.572','2023-02-03 16:26:17.755','2023-02-03 16:49:44.685'),
	(544,'ArticleManage','文章','pass','/admin/article','/0/543/544','C','無','admin:article:list',543,0,'','/admin/article/index',0,'0','0',1,1,'2023-02-03 15:20:56.595','2023-02-03 16:26:17.755',NULL),
	(545,'','分頁獲取文章','','article','/0/543/544/545','F','無','admin:article:query',544,0,'','',0,'0','0',1,1,'2023-02-03 15:20:56.610','2023-02-03 16:26:17.755',NULL),
	(546,'','創建文章','','article','/0/543/544/546','F','無','admin:article:add',544,0,'','',0,'0','0',1,1,'2023-02-03 15:20:56.622','2023-02-03 16:26:17.755',NULL),
	(547,'','修改文章','','article','/0/543/544/547','F','無','admin:article:edit',544,0,'','',0,'0','0',1,1,'2023-02-03 15:20:56.633','2023-02-03 16:26:17.755',NULL),
	(548,'','刪除文章','','article','/0/543/544/548','F','無','admin:article:remove',544,0,'','',0,'0','0',1,1,'2023-02-03 15:20:56.641','2023-02-03 16:26:17.755',NULL),
	(549,'','文章','pass','/article','/0/549','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 15:37:06.907','2023-02-03 15:37:06.912','2023-02-03 15:41:29.193'),
	(550,'ArticleManage','文章','pass','/admin/article','/0/549/550','C','無','admin:article:list',549,0,'','/admin/article/index',0,'0','0',1,1,'2023-02-03 15:37:06.927','2023-02-03 15:37:06.935',NULL),
	(551,'','分頁獲取文章','','article','/0/549/550/551','F','無','admin:article:query',550,0,'','',0,'0','0',1,1,'2023-02-03 15:37:06.944','2023-02-03 15:37:06.951',NULL),
	(552,'','創建文章','','article','/0/549/550/552','F','無','admin:article:add',550,0,'','',0,'0','0',1,1,'2023-02-03 15:37:06.958','2023-02-03 15:37:06.962',NULL),
	(553,'','修改文章','','article','/0/549/550/553','F','無','admin:article:edit',550,0,'','',0,'0','0',1,1,'2023-02-03 15:37:06.968','2023-02-03 15:37:06.972',NULL),
	(554,'','刪除文章','','article','/0/549/550/554','F','無','admin:article:remove',550,0,'','',0,'0','0',1,1,'2023-02-03 15:37:06.980','2023-02-03 15:37:06.984',NULL),
	(555,'','文章','pass','/article','/0/555','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 15:37:55.589','2023-02-03 15:37:55.593','2023-02-03 15:41:26.560'),
	(556,'ArticleManage','文章','pass','/admin/article','/0/555/556','C','無','admin:article:list',555,0,'','/admin/article/index',0,'0','0',1,1,'2023-02-03 15:37:55.607','2023-02-03 15:37:55.613',NULL),
	(557,'','分頁獲取文章','','article','/0/555/556/557','F','無','admin:article:query',556,0,'','',0,'0','0',1,1,'2023-02-03 15:37:55.626','2023-02-03 15:37:55.632',NULL),
	(558,'','創建文章','','article','/0/555/556/558','F','無','admin:article:add',556,0,'','',0,'0','0',1,1,'2023-02-03 15:37:55.640','2023-02-03 15:37:55.645',NULL),
	(559,'','修改文章','','article','/0/555/556/559','F','無','admin:article:edit',556,0,'','',0,'0','0',1,1,'2023-02-03 15:37:55.650','2023-02-03 15:37:55.654',NULL),
	(560,'','刪除文章','','article','/0/555/556/560','F','無','admin:article:remove',556,0,'','',0,'0','0',1,1,'2023-02-03 15:37:55.658','2023-02-03 15:37:55.661',NULL),
	(561,'','文章','pass','/article','/0/561','M','無','',0,0,'','Layout',0,'1','0',1,1,'2023-02-03 16:51:18.051','2023-02-03 17:11:20.578','2023-02-03 17:55:25.026'),
	(562,'ArticleManage','文章','pass','/admin/article','/0/561/562','C','無','admin:article:list',561,0,'','/admin/article/index',0,'0','0',1,1,'2023-02-03 16:51:18.071','2023-02-03 17:11:20.578',NULL),
	(563,'','分頁獲取文章','','article','/0/561/562/563','F','無','admin:article:query',562,0,'','',0,'0','0',1,1,'2023-02-03 16:51:18.086','2023-02-03 17:11:20.578',NULL),
	(564,'','創建文章','','article','/0/561/562/564','F','無','admin:article:add',562,0,'','',0,'0','0',1,1,'2023-02-03 16:51:18.099','2023-02-03 17:11:20.578',NULL),
	(565,'','修改文章','','article','/0/561/562/565','F','無','admin:article:edit',562,0,'','',0,'0','0',1,1,'2023-02-03 16:51:18.110','2023-02-03 17:11:20.578',NULL),
	(566,'','刪除文章','','article','/0/561/562/566','F','無','admin:article:remove',562,0,'','',0,'0','0',1,1,'2023-02-03 16:51:18.118','2023-02-03 17:11:20.578',NULL),
	(567,'','Products','pass','/products','/0/567','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 17:01:45.184','2023-02-03 17:11:20.578','2023-02-03 17:11:43.106'),
	(568,'ProductsManage','Products','pass','/admin/products','/0/567/568','C','無','admin:products:list',567,0,'','/admin/products/index',0,'0','0',1,1,'2023-02-03 17:01:45.195','2023-02-03 17:11:20.578',NULL),
	(569,'','分頁獲取Products','','products','/0/567/568/569','F','無','admin:products:query',568,0,'','',0,'0','0',1,1,'2023-02-03 17:01:45.205','2023-02-03 17:11:20.578',NULL),
	(570,'','創建Products','','products','/0/567/568/570','F','無','admin:products:add',568,0,'','',0,'0','0',1,1,'2023-02-03 17:01:45.217','2023-02-03 17:11:20.578',NULL),
	(571,'','修改Products','','products','/0/567/568/571','F','無','admin:products:edit',568,0,'','',0,'0','0',1,1,'2023-02-03 17:01:45.227','2023-02-03 17:11:20.578',NULL),
	(572,'','刪除Products','','products','/0/567/568/572','F','無','admin:products:remove',568,0,'','',0,'0','0',1,1,'2023-02-03 17:01:45.244','2023-02-03 17:11:20.578',NULL),
	(573,'','Products','pass','/products','/0/573','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 17:10:07.555','2023-02-03 17:11:20.578','2023-02-03 17:12:04.252'),
	(574,'ProductsManage','Products','pass','/admin/products','/0/573/574','C','無','admin:products:list',573,0,'','/admin/products/index',0,'0','0',1,1,'2023-02-03 17:10:07.577','2023-02-03 17:11:20.578',NULL),
	(575,'','分頁獲取Products','','products','/0/573/574/575','F','無','admin:products:query',574,0,'','',0,'0','0',1,1,'2023-02-03 17:10:07.590','2023-02-03 17:11:20.578',NULL),
	(576,'','創建Products','','products','/0/573/574/576','F','無','admin:products:add',574,0,'','',0,'0','0',1,1,'2023-02-03 17:10:07.601','2023-02-03 17:11:20.578',NULL),
	(577,'','修改Products','','products','/0/573/574/577','F','無','admin:products:edit',574,0,'','',0,'0','0',1,1,'2023-02-03 17:10:07.611','2023-02-03 17:11:20.578',NULL),
	(578,'','刪除Products','','products','/0/573/574/578','F','無','admin:products:remove',574,0,'','',0,'0','0',1,1,'2023-02-03 17:10:07.619','2023-02-03 17:11:20.578',NULL),
	(579,'','Products','pass','/products','/0/579','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 17:12:24.232','2023-02-03 17:12:24.236','2023-02-03 17:55:14.644'),
	(580,'ProductsManage','Products','pass','/admin/products','/0/579/580','C','無','admin:products:list',579,0,'','/admin/products/index',0,'0','0',1,1,'2023-02-03 17:12:24.250','2023-02-03 17:12:24.259',NULL),
	(581,'','分頁獲取Products','','products','/0/579/580/581','F','無','admin:products:query',580,0,'','',0,'0','0',1,1,'2023-02-03 17:12:24.268','2023-02-03 17:12:24.274',NULL),
	(582,'','創建Products','','products','/0/579/580/582','F','無','admin:products:add',580,0,'','',0,'0','0',1,1,'2023-02-03 17:12:24.282','2023-02-03 17:12:24.286',NULL),
	(583,'','修改Products','','products','/0/579/580/583','F','無','admin:products:edit',580,0,'','',0,'0','0',1,1,'2023-02-03 17:12:24.293','2023-02-03 17:12:24.299',NULL),
	(584,'','刪除Products','','products','/0/579/580/584','F','無','admin:products:remove',580,0,'','',0,'0','0',1,1,'2023-02-03 17:12:24.304','2023-02-03 17:12:24.308',NULL),
	(585,'','Products','pass','/products','/0/585','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 17:23:33.428','2023-02-03 17:23:33.433','2023-02-03 17:55:11.842'),
	(586,'ProductsManage','Products','pass','/admin/products','/0/585/586','C','無','admin:products:list',585,0,'','/admin/products/index',0,'0','0',1,1,'2023-02-03 17:23:33.447','2023-02-03 17:23:33.453',NULL),
	(587,'','分頁獲取Products','','products','/0/585/586/587','F','無','admin:products:query',586,0,'','',0,'0','0',1,1,'2023-02-03 17:23:33.462','2023-02-03 17:23:33.468',NULL),
	(588,'','創建Products','','products','/0/585/586/588','F','無','admin:products:add',586,0,'','',0,'0','0',1,1,'2023-02-03 17:23:33.475','2023-02-03 17:23:33.480',NULL),
	(589,'','修改Products','','products','/0/585/586/589','F','無','admin:products:edit',586,0,'','',0,'0','0',1,1,'2023-02-03 17:23:33.485','2023-02-03 17:23:33.489',NULL),
	(590,'','刪除Products','','products','/0/585/586/590','F','無','admin:products:remove',586,0,'','',0,'0','0',1,1,'2023-02-03 17:23:33.494','2023-02-03 17:23:33.497',NULL),
	(591,'','Products','pass','/products','/0/591','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 17:25:42.495','2023-02-03 17:25:42.499','2023-02-03 17:55:08.893'),
	(592,'ProductsManage','Products','pass','/admin/products','/0/591/592','C','無','admin:products:list',591,0,'','/admin/products/index',0,'0','0',1,1,'2023-02-03 17:25:42.515','2023-02-03 17:25:42.521',NULL),
	(593,'','分頁獲取Products','','products','/0/591/592/593','F','無','admin:products:query',592,0,'','',0,'0','0',1,1,'2023-02-03 17:25:42.530','2023-02-03 17:25:42.535',NULL),
	(594,'','創建Products','','products','/0/591/592/594','F','無','admin:products:add',592,0,'','',0,'0','0',1,1,'2023-02-03 17:25:42.542','2023-02-03 17:25:42.546',NULL),
	(595,'','修改Products','','products','/0/591/592/595','F','無','admin:products:edit',592,0,'','',0,'0','0',1,1,'2023-02-03 17:25:42.552','2023-02-03 17:25:42.556',NULL),
	(596,'','刪除Products','','products','/0/591/592/596','F','無','admin:products:remove',592,0,'','',0,'0','0',1,1,'2023-02-03 17:25:42.562','2023-02-03 17:25:42.565',NULL),
	(597,'','Products','pass','/products','/0/597','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 17:44:03.722','2023-02-03 17:44:03.724','2023-02-03 17:55:05.592'),
	(598,'ProductsManage','Products','pass','/admin/products','/0/597/598','C','無','admin:products:list',597,0,'','/admin/products/index',0,'0','0',1,1,'2023-02-03 17:44:03.728','2023-02-03 17:44:03.748',NULL),
	(599,'','分頁獲取Products','','products','/0/597/598/599','F','無','admin:products:query',598,0,'','',0,'0','0',1,1,'2023-02-03 17:44:03.753','2023-02-03 17:44:03.756',NULL),
	(600,'','創建Products','','products','/0/597/598/600','F','無','admin:products:add',598,0,'','',0,'0','0',1,1,'2023-02-03 17:44:03.760','2023-02-03 17:44:03.765',NULL),
	(601,'','修改Products','','products','/0/597/598/601','F','無','admin:products:edit',598,0,'','',0,'0','0',1,1,'2023-02-03 17:44:03.769','2023-02-03 17:44:03.772',NULL),
	(602,'','刪除Products','','products','/0/597/598/602','F','無','admin:products:remove',598,0,'','',0,'0','0',1,1,'2023-02-03 17:44:03.776','2023-02-03 17:44:03.779',NULL),
	(603,'','Brand','pass','/brand','/0/603','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 17:44:04.801','2023-02-03 17:44:04.805','2023-02-03 17:55:01.560'),
	(604,'BrandManage','Brand','pass','/admin/brand','/0/603/604','C','無','admin:brand:list',603,0,'','/admin/brand/index',0,'0','0',1,1,'2023-02-03 17:44:04.819','2023-02-03 17:44:04.826',NULL),
	(605,'','分頁獲取Brand','','brand','/0/603/604/605','F','無','admin:brand:query',604,0,'','',0,'0','0',1,1,'2023-02-03 17:44:04.835','2023-02-03 17:44:04.841',NULL),
	(606,'','創建Brand','','brand','/0/603/604/606','F','無','admin:brand:add',604,0,'','',0,'0','0',1,1,'2023-02-03 17:44:04.849','2023-02-03 17:44:04.853',NULL),
	(607,'','修改Brand','','brand','/0/603/604/607','F','無','admin:brand:edit',604,0,'','',0,'0','0',1,1,'2023-02-03 17:44:04.859','2023-02-03 17:44:04.863',NULL),
	(608,'','刪除Brand','','brand','/0/603/604/608','F','無','admin:brand:remove',604,0,'','',0,'0','0',1,1,'2023-02-03 17:44:04.867','2023-02-03 17:44:04.870',NULL),
	(609,'','Brand','pass','/brand','/0/609','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 22:36:09.963','2023-02-03 22:36:09.969','2023-02-03 22:53:42.560'),
	(610,'BrandManage','Brand','pass','/admin/brand','/0/609/610','C','無','admin:brand:list',609,0,'','/admin/brand/index',0,'0','0',1,1,'2023-02-03 22:36:09.982','2023-02-03 22:36:09.989',NULL),
	(611,'','分頁獲取Brand','','brand','/0/609/610/611','F','無','admin:brand:query',610,0,'','',0,'0','0',1,1,'2023-02-03 22:36:09.998','2023-02-03 22:36:10.003',NULL),
	(612,'','創建Brand','','brand','/0/609/610/612','F','無','admin:brand:add',610,0,'','',0,'0','0',1,1,'2023-02-03 22:36:10.009','2023-02-03 22:36:10.013',NULL),
	(613,'','修改Brand','','brand','/0/609/610/613','F','無','admin:brand:edit',610,0,'','',0,'0','0',1,1,'2023-02-03 22:36:10.018','2023-02-03 22:36:10.022',NULL),
	(614,'','删除Brand','','brand','/0/609/610/614','F','無','admin:brand:remove',610,0,'','',0,'0','0',1,1,'2023-02-03 22:36:10.027','2023-02-03 22:36:10.030',NULL),
	(615,'','Brand','pass','/brand','/0/615','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 22:51:12.541','2023-02-03 22:51:12.546','2023-02-03 22:53:40.609'),
	(616,'BrandManage','Brand','pass','/admin/brand','/0/615/616','C','無','admin:brand:list',615,0,'','/admin/brand/index',0,'0','0',1,1,'2023-02-03 22:51:12.562','2023-02-03 22:51:12.569',NULL),
	(617,'','分頁獲取Brand','','brand','/0/615/616/617','F','無','admin:brand:query',616,0,'','',0,'0','0',1,1,'2023-02-03 22:51:12.578','2023-02-03 22:51:12.585',NULL),
	(618,'','創建Brand','','brand','/0/615/616/618','F','無','admin:brand:add',616,0,'','',0,'0','0',1,1,'2023-02-03 22:51:12.592','2023-02-03 22:51:12.596',NULL),
	(619,'','修改Brand','','brand','/0/615/616/619','F','無','admin:brand:edit',616,0,'','',0,'0','0',1,1,'2023-02-03 22:51:12.601','2023-02-03 22:51:12.605',NULL),
	(620,'','删除Brand','','brand','/0/615/616/620','F','無','admin:brand:remove',616,0,'','',0,'0','0',1,1,'2023-02-03 22:51:12.610','2023-02-03 22:51:12.613',NULL),
	(621,'','Brand','pass','/brand','/0/621','M','無','',0,0,'','Layout',0,'0','0',1,0,'2023-02-03 22:54:17.706','2023-02-03 22:54:17.710','2023-02-06 15:55:00.566'),
	(622,'BrandManage','Brand','pass','/admin/brand','/0/621/622','C','無','admin:brand:list',621,0,'','/admin/brand/index',0,'0','0',1,1,'2023-02-03 22:54:17.725','2023-02-03 22:54:17.731',NULL),
	(623,'','分頁獲取Brand','','brand','/0/621/622/623','F','無','admin:brand:query',622,0,'','',0,'0','0',1,1,'2023-02-03 22:54:17.741','2023-02-03 22:54:17.746',NULL),
	(624,'','創建Brand','','brand','/0/621/622/624','F','無','admin:brand:add',622,0,'','',0,'0','0',1,1,'2023-02-03 22:54:17.754','2023-02-03 22:54:17.759',NULL),
	(625,'','修改Brand','','brand','/0/621/622/625','F','無','admin:brand:edit',622,0,'','',0,'0','0',1,1,'2023-02-03 22:54:17.764','2023-02-03 22:54:17.768',NULL),
	(626,'','删除Brand','','brand','/0/621/622/626','F','無','admin:brand:remove',622,0,'','',0,'0','0',1,1,'2023-02-03 22:54:17.773','2023-02-03 22:54:17.776',NULL);

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_menu_api_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu_api_rule`;

CREATE TABLE `sys_menu_api_rule` (
  `sys_menu_menu_id` bigint(20) NOT NULL,
  `sys_api_id` bigint(20) NOT NULL COMMENT '主鍵編碼',
  PRIMARY KEY (`sys_menu_menu_id`,`sys_api_id`),
  KEY `fk_sys_menu_api_rule_sys_api` (`sys_api_id`),
  CONSTRAINT `fk_sys_menu_api_rule_sys_api` FOREIGN KEY (`sys_api_id`) REFERENCES `sys_api` (`id`),
  CONSTRAINT `fk_sys_menu_api_rule_sys_menu` FOREIGN KEY (`sys_menu_menu_id`) REFERENCES `sys_menu` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_menu_api_rule` WRITE;
/*!40000 ALTER TABLE `sys_menu_api_rule` DISABLE KEYS */;

INSERT INTO `sys_menu_api_rule` (`sys_menu_menu_id`, `sys_api_id`)
VALUES
	(3,141),
	(43,150),
	(44,141),
	(45,142),
	(45,151),
	(46,156),
	(51,39),
	(51,135),
	(52,44),
	(56,27),
	(57,59),
	(58,21),
	(58,26),
	(59,24),
	(62,53),
	(212,137),
	(216,6),
	(220,88),
	(221,41),
	(221,109),
	(222,39),
	(223,126),
	(224,90),
	(225,44),
	(226,29),
	(226,45),
	(226,46),
	(226,47),
	(226,106),
	(226,107),
	(227,128),
	(228,27),
	(229,82),
	(230,28),
	(230,103),
	(231,122),
	(232,59),
	(233,89),
	(234,60),
	(234,110),
	(235,127),
	(236,21),
	(236,26),
	(237,81),
	(238,23),
	(238,102),
	(239,121),
	(240,24),
	(241,80),
	(242,25),
	(242,101),
	(243,120),
	(244,53),
	(245,87),
	(246,54),
	(246,108),
	(247,125),
	(248,137),
	(249,114),
	(250,6),
	(251,115),
	(528,135),
	(529,135),
	(531,92),
	(531,136),
	(540,140),
	(542,139),
	(563,5),
	(563,6),
	(563,7),
	(563,8),
	(563,9),
	(563,10),
	(563,11),
	(563,15),
	(563,16),
	(563,21),
	(563,22),
	(563,23),
	(563,24),
	(563,25),
	(563,26),
	(563,27),
	(563,28),
	(563,29),
	(563,30),
	(563,31),
	(563,32),
	(563,33),
	(563,34),
	(563,35),
	(563,36),
	(563,37),
	(563,38),
	(563,39),
	(563,40),
	(563,41),
	(563,42),
	(563,43),
	(563,44),
	(563,45),
	(563,46),
	(563,47),
	(563,48),
	(563,53),
	(563,54),
	(563,55),
	(563,57),
	(563,58),
	(563,59),
	(563,60),
	(563,62),
	(563,63),
	(563,66),
	(563,67),
	(563,68),
	(563,72),
	(563,73),
	(563,76),
	(563,80),
	(563,81),
	(563,82),
	(563,85),
	(563,86),
	(563,87),
	(563,88),
	(563,89),
	(563,90),
	(563,91),
	(563,92),
	(563,95),
	(563,96),
	(563,97),
	(563,101),
	(563,102),
	(563,103),
	(563,104),
	(563,105),
	(563,106),
	(563,107),
	(563,108),
	(563,109),
	(563,110),
	(563,111),
	(563,112),
	(563,113),
	(563,114),
	(563,115),
	(563,116),
	(563,117),
	(563,120),
	(563,121),
	(563,122),
	(563,123),
	(563,124),
	(563,125),
	(563,126),
	(563,127),
	(563,128),
	(563,131),
	(563,132),
	(563,133),
	(563,134),
	(563,135),
	(563,136),
	(563,137),
	(563,138),
	(563,139),
	(563,140),
	(563,141),
	(563,142),
	(563,143),
	(563,144),
	(563,145),
	(563,146),
	(563,147),
	(563,148),
	(563,149),
	(563,150),
	(563,151),
	(563,152),
	(563,153),
	(563,154),
	(563,155),
	(563,156),
	(563,157),
	(563,158),
	(563,159),
	(563,160);

/*!40000 ALTER TABLE `sys_menu_api_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_migration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_migration`;

CREATE TABLE `sys_migration` (
  `version` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apply_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `sys_migration` WRITE;
/*!40000 ALTER TABLE `sys_migration` DISABLE KEYS */;

INSERT INTO `sys_migration` (`version`, `apply_time`)
VALUES
	('1599190683659','2023-02-03 14:32:11.413'),
	('1653638869132','2023-02-03 14:32:11.600');

/*!40000 ALTER TABLE `sys_migration` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_opera_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_opera_log`;

CREATE TABLE `sys_opera_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主鍵編碼',
  `title` varchar(255) DEFAULT NULL COMMENT '操作模塊',
  `business_type` varchar(128) DEFAULT NULL COMMENT '操作類型',
  `business_types` varchar(128) DEFAULT NULL COMMENT 'BusinessTypes',
  `method` varchar(128) DEFAULT NULL COMMENT '函數',
  `request_method` varchar(128) DEFAULT NULL COMMENT '請求方式: GET POST PUT DELETE',
  `operator_type` varchar(128) DEFAULT NULL COMMENT '操作類型',
  `oper_name` varchar(128) DEFAULT NULL COMMENT '操作者',
  `dept_name` varchar(128) DEFAULT NULL COMMENT '部門名稱',
  `oper_url` varchar(255) DEFAULT NULL COMMENT '訪問地址',
  `oper_ip` varchar(128) DEFAULT NULL COMMENT '客戶端ip',
  `oper_location` varchar(128) DEFAULT NULL COMMENT '訪問位置',
  `oper_param` text DEFAULT NULL COMMENT '請求參數',
  `status` varchar(4) DEFAULT NULL COMMENT '操作狀態 1:正常 2:關閉',
  `oper_time` timestamp NULL DEFAULT NULL COMMENT '操作時間',
  `json_result` varchar(255) DEFAULT NULL COMMENT '返回資料',
  `remark` varchar(255) DEFAULT NULL COMMENT '備註',
  `latency_time` varchar(128) DEFAULT NULL COMMENT '耗時',
  `user_agent` varchar(255) DEFAULT NULL COMMENT 'ua',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`id`),
  KEY `idx_sys_opera_log_create_by` (`create_by`),
  KEY `idx_sys_opera_log_update_by` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table sys_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_post`;

CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_name` varchar(128) DEFAULT NULL,
  `post_code` varchar(128) DEFAULT NULL,
  `sort` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`post_id`),
  KEY `idx_sys_post_create_by` (`create_by`),
  KEY `idx_sys_post_update_by` (`update_by`),
  KEY `idx_sys_post_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;

INSERT INTO `sys_post` (`post_id`, `post_name`, `post_code`, `sort`, `status`, `remark`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'執行長','CEO',0,2,'',1,1,'2021-05-13 19:56:37.913','2023-02-06 16:16:10.670',NULL),
	(2,'技術長','CTO',2,2,'技術長',1,1,'2021-05-13 19:56:37.913','2021-05-13 19:56:37.913','2023-02-06 16:16:24.747'),
	(3,'營運長','COO',3,2,'測試工程師',1,1,'2021-05-13 19:56:37.913','2021-05-13 19:56:37.913','2023-02-06 16:16:27.261');

/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(128) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL,
  `role_key` varchar(128) DEFAULT NULL,
  `role_sort` bigint(20) DEFAULT NULL,
  `flag` varchar(128) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `data_scope` varchar(128) DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`role_id`),
  KEY `idx_sys_role_create_by` (`create_by`),
  KEY `idx_sys_role_update_by` (`update_by`),
  KEY `idx_sys_role_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`role_id`, `role_name`, `status`, `role_key`, `role_sort`, `flag`, `remark`, `admin`, `data_scope`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'系統管理員','2','admin',1,'','',1,'',1,1,'2021-05-13 19:56:37.913','2021-05-13 19:56:37.913',NULL),
	(2,'普通角色','1','com',0,'','',0,'1',0,0,'2023-02-03 15:27:50.506','2023-02-03 15:51:09.284','2023-02-03 15:51:53.955'),
	(3,'test','2','test',0,'','',0,'1',0,0,'2023-02-03 15:53:51.808','2023-02-03 17:11:20.574','2023-02-03 22:31:27.948'),
	(4,'test','2','test',0,'','',0,'',0,0,'2023-02-05 21:06:15.825','2023-02-05 21:06:15.825',NULL);

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_role_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_dept`;

CREATE TABLE `sys_role_dept` (
  `role_id` smallint(6) NOT NULL,
  `dept_id` smallint(6) NOT NULL,
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table sys_role_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `fk_sys_role_menu_sys_menu` (`menu_id`),
  CONSTRAINT `fk_sys_role_menu_sys_menu` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`menu_id`),
  CONSTRAINT `fk_sys_role_menu_sys_role` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;

INSERT INTO `sys_role_menu` (`role_id`, `menu_id`)
VALUES
	(4,621),
	(4,622),
	(4,623),
	(4,624),
	(4,625),
	(4,626);

/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_tables
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_tables`;

CREATE TABLE `sys_tables` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) DEFAULT NULL,
  `table_comment` varchar(255) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `tpl_category` varchar(255) DEFAULT NULL,
  `package_name` varchar(255) DEFAULT NULL,
  `module_name` varchar(255) DEFAULT NULL,
  `module_front_name` varchar(255) DEFAULT NULL COMMENT '前端文件名',
  `business_name` varchar(255) DEFAULT NULL,
  `function_name` varchar(255) DEFAULT NULL,
  `function_author` varchar(255) DEFAULT NULL,
  `pk_column` varchar(255) DEFAULT NULL,
  `pk_go_field` varchar(255) DEFAULT NULL,
  `pk_json_field` varchar(255) DEFAULT NULL,
  `options` varchar(255) DEFAULT NULL,
  `tree_code` varchar(255) DEFAULT NULL,
  `tree_parent_code` varchar(255) DEFAULT NULL,
  `tree_name` varchar(255) DEFAULT NULL,
  `tree` tinyint(1) DEFAULT 0,
  `crud` tinyint(1) DEFAULT 1,
  `remark` varchar(255) DEFAULT NULL,
  `is_data_scope` tinyint(4) DEFAULT NULL,
  `is_actions` tinyint(4) DEFAULT NULL,
  `is_auth` tinyint(4) DEFAULT NULL,
  `is_logical_delete` varchar(1) DEFAULT NULL,
  `logical_delete` tinyint(1) DEFAULT NULL,
  `logical_delete_column` varchar(128) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`table_id`),
  KEY `idx_sys_tables_deleted_at` (`deleted_at`),
  KEY `idx_sys_tables_create_by` (`create_by`),
  KEY `idx_sys_tables_update_by` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '編碼',
  `username` varchar(64) DEFAULT NULL COMMENT '使用者名',
  `password` varchar(128) DEFAULT NULL COMMENT '密碼',
  `nick_name` varchar(128) DEFAULT NULL COMMENT '昵稱',
  `phone` varchar(11) DEFAULT NULL COMMENT '手機號',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `salt` varchar(255) DEFAULT NULL COMMENT '加鹽',
  `avatar` varchar(255) DEFAULT NULL COMMENT '頭像',
  `sex` varchar(255) DEFAULT NULL COMMENT '性別',
  `email` varchar(128) DEFAULT NULL COMMENT '郵箱',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部門',
  `post_id` bigint(20) DEFAULT NULL COMMENT '職位',
  `remark` varchar(255) DEFAULT NULL COMMENT '備註',
  `status` varchar(4) DEFAULT NULL COMMENT '狀態',
  `create_by` bigint(20) DEFAULT NULL COMMENT '創建者',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `created_at` datetime(3) DEFAULT NULL COMMENT '創建時間',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '最後更新時間',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '刪除時間',
  PRIMARY KEY (`user_id`),
  KEY `idx_sys_user_deleted_at` (`deleted_at`),
  KEY `idx_sys_user_create_by` (`create_by`),
  KEY `idx_sys_user_update_by` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`user_id`, `username`, `password`, `nick_name`, `phone`, `role_id`, `salt`, `avatar`, `sex`, `email`, `dept_id`, `post_id`, `remark`, `status`, `create_by`, `update_by`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'admin','$2a$10$/Glr4g9Svr6O0kvjsRJCXu3f0W8/dsP3XZyVNi1019ratWpSPMyw.','admin','13818888888',1,'','','1','admin@test.com',1,1,'','2',1,1,'2021-05-13 19:56:37.914','2021-05-13 19:56:40.205',NULL),
	(2,'andy','$2a$10$.iicLOAJqGgrhrh7sETheORdkNmrB42KwSXmoKZ/c7LoVJQJSQcQe','andy','0912339728',3,'','','','andy.wang@gaia.net',7,0,'','2',1,1,'2023-02-03 15:31:56.209','2023-02-03 15:54:31.912',NULL),
	(3,'test','$2a$10$y/DcHUxTiPlXGPqhG4hPqOg/nFXDGerOU6kitCTMOLxfSneUgEVzm','test','0912339333',0,'','','0','test@tfest.com',16,1,'','2',1,0,'2023-02-06 16:15:45.918','2023-02-06 16:15:45.918',NULL);

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
