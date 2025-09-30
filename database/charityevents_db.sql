/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80036
Source Host           : localhost:3306
Source Database       : charityevents_db

Target Server Type    : MYSQL
Target Server Version : 80036
File Encoding         : 65001

Date: 2025-09-30 20:27:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `icon_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES ('1', '教育支持', '支持教育发展和学习机会的活动', 'https://cdn-icons-png.flaticon.com/512/3133/3133993.png');
INSERT INTO `categories` VALUES ('2', '环境保护', '关注环境问题和生态保护的活动', 'https://cdn-icons-png.flaticon.com/512/1946/1946485.png');
INSERT INTO `categories` VALUES ('3', '健康医疗', '提供医疗服务和健康支持的活动', 'https://cdn-icons-png.flaticon.com/512/1488/1488958.png');
INSERT INTO `categories` VALUES ('4', '灾难救助', '为自然灾害和人道主义危机提供援助的活动', 'https://cdn-icons-png.flaticon.com/512/3072/3072668.png');
INSERT INTO `categories` VALUES ('5', '儿童福利', '关注儿童权益和福利的活动', 'https://cdn-icons-png.flaticon.com/512/2885/2885000.png');
INSERT INTO `categories` VALUES ('6', '社区发展', '促进社区建设和发展的活动', 'https://cdn-icons-png.flaticon.com/512/3075/3075642.png');

-- ----------------------------
-- Table structure for charities
-- ----------------------------
DROP TABLE IF EXISTS `charities`;
CREATE TABLE `charities` (
  `charity_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `logo_url` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`charity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of charities
-- ----------------------------
INSERT INTO `charities` VALUES ('1', '中国红十字会', '致力于提供人道主义援助和灾难救助', 'https://upload.wikimedia.org/wikipedia/commons/3/36/Chinese_Red_Cross_Logo.svg', 'https://www.redcross.org.cn', 'redcross315@163.com', '010-84050082', '北京市东城区东单北大街53号', '2025-09-29 23:37:54');
INSERT INTO `charities` VALUES ('2', '希望工程', '专注于改善贫困地区儿童教育条件', 'https://www.cydf.org.cn/images/logo.png', 'https://www.cydf.org.cn/project_hope', 'info@cydf.org.cn', '010-65680585', '北京市东城区前门东大街10号', '2025-09-29 23:37:54');
INSERT INTO `charities` VALUES ('3', '绿色和平', '致力于环境保护和可持续发展', 'https://www.greenpeace.org/international/wp-content/uploads/2018/01/greenpeace-logo-1.png', 'https://www.greenpeace.org/china', 'greenpeace.cn@greenpeace.org', '+86-10-65546931', '北京市东城区东四十条甲94号亮点文创园A座201室', '2025-09-29 23:37:54');
INSERT INTO `charities` VALUES ('4', '联合国儿童基金会', '保护儿童权益，提供健康和教育支持', 'https://www.unicef.org/sites/all/themes/unicef/images/unicef-logo.svg', 'https://www.unicef.cn', 'beijing@unicef.org', '+86-10-85318430', '北京市朝阳区三里屯路12号', '2025-09-29 23:37:54');

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `address` text,
  `city` varchar(50) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `registration_url` varchar(255) DEFAULT NULL,
  `charity_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_id`),
  KEY `charity_id` (`charity_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`charity_id`) REFERENCES `charities` (`charity_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES ('1', '希望小学筹款活动', '为贫困地区建设希望小学筹集资金的慈善活动', '2023-10-15', '2023-10-15', '18:00:00', '21:00:00', '北京国际饭店', '北京市朝阳区建国门外大街1号', '北京', 'https://images.unsplash.com/photo-1509099836639-18ba1795216d', 'https://www.cydf.org.cn/donate/', '2', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('2', '植树造林活动', '在城市周边地区组织志愿者参与植树活动，改善生态环境', '2023-11-05', '2023-11-05', '09:00:00', '16:00:00', '北京市密云区', '北京市密云区水源保护区', '北京', 'https://images.unsplash.com/photo-1513836279014-a89f7a76ae86', 'https://www.greenpeace.org/china/act/', '3', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('3', '免费医疗义诊', '为社区居民提供免费健康检查和医疗咨询', '2023-10-28', '2023-10-29', '08:30:00', '17:00:00', '上海市第一人民医院', '上海市虹口区武进路300号', '上海', 'https://images.unsplash.com/photo-1576091160550-2173dba999ef', 'https://www.redcross.org.cn/html/jz/', '1', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('4', '灾区儿童心理援助', '为自然灾害中受影响的儿童提供心理辅导和支持', '2023-11-10', '2023-11-12', '09:00:00', '18:00:00', '四川省绵阳市', '四川省绵阳市涪城区', '绵阳', 'https://images.unsplash.com/photo-1523240795612-9a054b0db644', 'https://www.unicef.cn/donate/', '4', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('5', '社区图书馆建设', '为农村地区建设社区图书馆，提供阅读资源', '2023-12-01', '2023-12-10', '08:00:00', '17:00:00', '河南省周口市', '河南省周口市川汇区', '周口', 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6', 'https://www.cydf.org.cn/project_hope/donate/', '2', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('6', '环保讲座系列', '关于气候变化和可持续生活方式的公开讲座', '2023-11-15', '2023-11-17', '19:00:00', '21:00:00', '广州图书馆', '广州市天河区珠江新城珠江西路', '广州', 'https://images.unsplash.com/photo-1517433456452-f9633a875f6f', 'https://www.greenpeace.org/china/support-us/', '3', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('7', '儿童疫苗接种日', '为贫困地区儿童提供免费疫苗接种服务', '2023-10-20', '2023-10-20', '08:00:00', '16:00:00', '云南省昆明市儿童医院', '云南省昆明市盘龙区金江路', '昆明', 'https://images.unsplash.com/photo-1584516150909-cdfd40880934', 'https://www.unicef.cn/donate/', '4', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('8', '老年人关爱活动', '为孤寡老人提供生活用品和心理关怀', '2023-12-20', '2023-12-20', '14:00:00', '17:00:00', '北京市朝阳区敬老院', '北京市朝阳区建国路89号', '北京', 'https://images.unsplash.com/photo-1570549717483-5ed389df5cd0', 'https://www.redcross.org.cn/html/jz/', '1', '2025-09-29 23:37:55');
INSERT INTO `events` VALUES ('9', 'World Red Cross Day Celebration', 'Annual event promoting humanitarian aid and community health awareness.', '2025-05-08', '2025-05-08', '09:00:00', '17:00:00', 'Beijing Red Cross Center', '北京市东城区东单北大街53号', 'Beijing', 'https://images.unsplash.com/photo-1515169067868-5387ec3568e4', 'https://www.redcross.org.cn/html/jz/', '1', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('10', 'Resilience Forum on Disasters', 'Forum on building community resilience against natural disasters.', '2025-03-07', '2025-03-07', '09:30:00', '13:00:00', 'Beijing Conference Hall', '北京市朝阳区亮马河南路14号', 'Beijing', 'https://images.unsplash.com/photo-1542744173-05336fcc7ad0', 'https://www.redcross.org.cn/html/jz/', '1', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('11', 'Gansu Earthquake Relief', 'Emergency response providing aid to earthquake victims in Gansu.', '2023-12-19', '2023-12-31', '00:00:00', '23:59:00', 'Gansu Province', '甘肃省积石山县', 'Lanzhou', 'https://images.unsplash.com/photo-1544027995-e27147a8d6b5', 'https://www.redcross.org.cn/html/jz/', '1', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('12', 'Tibet Earthquake Response', 'Support for victims of the Shigatse earthquake with relief supplies.', '2025-01-01', '2025-01-15', '08:00:00', '18:00:00', 'Shigatse Region', '西藏日喀则市', 'Shigatse', 'https://images.unsplash.com/photo-1544027995-e27147a8d6b5', 'https://www.redcross.org.cn/html/jz/', '1', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('13', 'Rural Lung Cancer Detection', 'Program to improve early detection of lung cancer in rural areas.', '2023-01-01', '2025-12-31', null, null, 'Rural Communities', '中国农村地区', 'Various', 'https://images.unsplash.com/photo-1576091160550-2173dba999ef', 'https://www.cydf.org.cn/donate/', '2', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('14', 'Post-Earthquake Rehab Training', 'Rehabilitative training for earthquake survivors, focusing on health.', '2023-01-01', '2023-12-31', '09:00:00', '17:00:00', 'Sichuan Province', '四川省成都市', 'Chengdu', 'https://images.unsplash.com/photo-1584516150909-cdfd40880934', 'https://www.cydf.org.cn/donate/', '2', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('15', 'Green Future Photo Exhibition', 'Exhibition showcasing environmental changes and energy transitions.', '2025-09-17', '2025-09-20', '10:00:00', '18:00:00', 'Beijing Art Gallery', '北京市东城区', 'Beijing', 'https://images.unsplash.com/photo-1517433456452-f9633a875f6f', 'https://www.greenpeace.org/china/support-us/', '3', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('16', 'Steel Decarbonization Workshop', 'Workshop on financing low-carbon transitions in the steel industry.', '2025-09-24', '2025-09-24', '09:00:00', '17:00:00', 'Shanghai Conference Center', '上海市静安区', 'Shanghai', 'https://images.unsplash.com/photo-1513836279014-a89f7a76ae86', 'https://www.greenpeace.org/china/support-us/', '3', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('17', 'Green Energy Investment Conf', 'Conference on overseas green energy investments and strategies.', '2025-09-30', '2025-09-30', '09:00:00', '17:00:00', 'Guangzhou Expo Hall', '广州市天河区', 'Guangzhou', 'https://images.unsplash.com/photo-1517433456452-f9633a875f6f', 'https://www.greenpeace.org/china/support-us/', '3', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('18', 'Ocean Protection Campaign', 'Campaign celebrating the BBNJ agreement for global ocean conservation.', '2025-09-22', '2025-09-30', null, null, 'Coastal Cities', '上海市沿海地区', 'Shanghai', 'https://images.unsplash.com/photo-1513836279014-a89f7a76ae86', 'https://www.greenpeace.org/china/support-us/', '3', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('19', 'Light Every Moment Campaign', 'Initiative promoting positive parenting and child development.', '2023-01-01', '2025-12-31', null, null, 'Nationwide', '中国各地', 'Various', 'https://images.unsplash.com/photo-1523240795612-9a054b0db644', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('20', 'Positive Parenting Promotion', 'Promotion of non-violent parenting techniques in Guangxi.', '2023-06-01', '2023-12-31', '09:00:00', '17:00:00', 'Guangxi Region', '广西南宁市', 'Nanning', 'https://images.unsplash.com/photo-1523240795612-9a054b0db644', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('21', 'World Children\'s Day Event', 'Nationwide event lighting up cities in blue for children\'s rights.', '2023-11-20', '2023-11-20', '18:00:00', '22:00:00', 'Multiple Cities', '北京市朝阳区', 'Beijing', 'https://images.unsplash.com/photo-1509099836639-18ba1795216d', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('22', 'Child Care Allowance Advocacy', 'Advocacy for new child care allowances to support families.', '2025-08-08', '2025-12-31', null, null, 'Beijing Policy Center', '北京市朝阳区三里屯路12号', 'Beijing', 'https://images.unsplash.com/photo-1584516150909-cdfd40880934', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('23', 'Special Olympics Partnership', 'Collaboration to promote inclusion for children with disabilities.', '2023-09-12', '2025-12-31', null, null, 'East Asia Regions', '北京市', 'Beijing', 'https://images.unsplash.com/photo-1570549717483-5ed389df5cd0', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('24', 'British Charity Ball for Kids', 'Themed ball raising funds for underprivileged children\'s education and care.', '2025-04-26', '2025-04-26', '18:00:00', '02:00:00', 'Ritz-Carlton Guangzhou', '广州市天河区珠江新城', 'Guangzhou', 'https://images.unsplash.com/photo-1509099836639-18ba1795216d', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('25', 'Safe Schools Program Pilot', 'Piloting safe school initiatives to prevent violence and promote learning.', '2023-01-01', '2025-12-31', null, null, 'Nationwide Schools', '中国学校', 'Various', 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('26', 'Oral Health Initiative', 'Improving oral health for vulnerable children in rural and urban areas.', '2023-01-01', '2025-12-31', '08:00:00', '17:00:00', 'Rural and Urban Areas', '四川省成都市', 'Chengdu', 'https://images.unsplash.com/photo-1576091160550-2173dba999ef', 'https://www.unicef.cn/donate/', '4', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('27', 'Zayed Charity Run', 'Charity run to support health and community welfare.', '2025-09-20', '2025-09-20', '07:00:00', '12:00:00', 'Beijing Olympic Park', '北京市朝阳区', 'Beijing', 'https://images.unsplash.com/photo-1515169067868-5387ec3568e4', 'https://www.redcross.org.cn/html/jz/', '1', '2025-09-30 20:18:16');
INSERT INTO `events` VALUES ('28', 'Great Wall Charity Trek', 'Trek to raise funds for education and community development.', '2025-10-13', '2025-10-20', '08:00:00', '18:00:00', 'Great Wall Sections', '北京市怀柔区', 'Beijing', 'https://images.unsplash.com/photo-1513836279014-a89f7a76ae86', 'https://www.cydf.org.cn/donate/', '2', '2025-09-30 20:18:16');

-- ----------------------------
-- Table structure for event_categories
-- ----------------------------
DROP TABLE IF EXISTS `event_categories`;
CREATE TABLE `event_categories` (
  `event_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `event_categories_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE,
  CONSTRAINT `event_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of event_categories
-- ----------------------------
INSERT INTO `event_categories` VALUES ('1', '1');
INSERT INTO `event_categories` VALUES ('5', '1');
INSERT INTO `event_categories` VALUES ('6', '1');
INSERT INTO `event_categories` VALUES ('15', '1');
INSERT INTO `event_categories` VALUES ('19', '1');
INSERT INTO `event_categories` VALUES ('25', '1');
INSERT INTO `event_categories` VALUES ('28', '1');
INSERT INTO `event_categories` VALUES ('2', '2');
INSERT INTO `event_categories` VALUES ('6', '2');
INSERT INTO `event_categories` VALUES ('15', '2');
INSERT INTO `event_categories` VALUES ('16', '2');
INSERT INTO `event_categories` VALUES ('17', '2');
INSERT INTO `event_categories` VALUES ('18', '2');
INSERT INTO `event_categories` VALUES ('3', '3');
INSERT INTO `event_categories` VALUES ('7', '3');
INSERT INTO `event_categories` VALUES ('8', '3');
INSERT INTO `event_categories` VALUES ('9', '3');
INSERT INTO `event_categories` VALUES ('13', '3');
INSERT INTO `event_categories` VALUES ('14', '3');
INSERT INTO `event_categories` VALUES ('20', '3');
INSERT INTO `event_categories` VALUES ('22', '3');
INSERT INTO `event_categories` VALUES ('26', '3');
INSERT INTO `event_categories` VALUES ('27', '3');
INSERT INTO `event_categories` VALUES ('4', '4');
INSERT INTO `event_categories` VALUES ('10', '4');
INSERT INTO `event_categories` VALUES ('11', '4');
INSERT INTO `event_categories` VALUES ('12', '4');
INSERT INTO `event_categories` VALUES ('14', '4');
INSERT INTO `event_categories` VALUES ('18', '4');
INSERT INTO `event_categories` VALUES ('1', '5');
INSERT INTO `event_categories` VALUES ('4', '5');
INSERT INTO `event_categories` VALUES ('7', '5');
INSERT INTO `event_categories` VALUES ('12', '5');
INSERT INTO `event_categories` VALUES ('13', '5');
INSERT INTO `event_categories` VALUES ('14', '5');
INSERT INTO `event_categories` VALUES ('19', '5');
INSERT INTO `event_categories` VALUES ('20', '5');
INSERT INTO `event_categories` VALUES ('21', '5');
INSERT INTO `event_categories` VALUES ('22', '5');
INSERT INTO `event_categories` VALUES ('23', '5');
INSERT INTO `event_categories` VALUES ('24', '5');
INSERT INTO `event_categories` VALUES ('25', '5');
INSERT INTO `event_categories` VALUES ('26', '5');
INSERT INTO `event_categories` VALUES ('3', '6');
INSERT INTO `event_categories` VALUES ('5', '6');
INSERT INTO `event_categories` VALUES ('8', '6');
INSERT INTO `event_categories` VALUES ('9', '6');
INSERT INTO `event_categories` VALUES ('10', '6');
INSERT INTO `event_categories` VALUES ('23', '6');
INSERT INTO `event_categories` VALUES ('24', '6');
INSERT INTO `event_categories` VALUES ('27', '6');
INSERT INTO `event_categories` VALUES ('28', '6');
