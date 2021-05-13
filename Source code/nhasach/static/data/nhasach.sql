-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nhasach
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `date` datetime NOT NULL,
  `total_price` float NOT NULL,
  `paid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_detail`
--

DROP TABLE IF EXISTS `bill_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill_detail` (
  `bill_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`bill_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `bill_detail_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`),
  CONSTRAINT `bill_detail_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_detail`
--

LOCK TABLES `bill_detail` WRITE;
/*!40000 ALTER TABLE `bill_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `author` varchar(50) NOT NULL,
  `amount` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'Conan tập 1','Mở đầu câu truyện, cậu học sinh trung học 16 tuổi Shinichi Kudo bị biến thành cậu bé Conan Edogawa. Shinichi trong phần đầu của Thám tử lừng danh Conan được miêu tả là một thám tử học đường. Trong một lần đi chơi công viên \"Miền Nhiệt đới\" với cô bạn từ thuở nhỏ (cũng là bạn gái) Ran Mori , cậu bị dính vào vụ án một hành khách trên Chuyến tàu tốc hành trong công viên, Kishida , bị giết trong một vụ án cắt đầu rùng rợn. Cậu đã làm sáng tỏ vụ án và trên đường về nhà, chứng kiến một vụ làm ăn mờ ám của những người đàn ông mặc toàn đồ đen. Kudo bị phát hiện, bị đánh ngất sau đó những người đàn ông áo đen đã cho cậu uống một thứ thuốc độc chưa qua thử nghiệm là Apotoxin-4869 (APTX4869) với mục đích thủ tiêu cậu. Tuy nhiên chất độc đã không giết chết Kudo. Khi tỉnh lại, cậu bàng hoàng nhận thấy thân thể mình đã bị teo nhỏ trong hình dạng của một cậu học sinh tiểu học....',20000,'Gosho Aoyama',100,'static/images/Conan_tap1.jpg',1),(2,'Conan tập 2','Mở đầu câu truyện, cậu học sinh trung học 16 tuổi Shinichi Kudo bị biến thành cậu bé Conan Edogawa. Shinichi trong phần đầu của Thám tử lừng danh Conan được miêu tả là một thám tử học đường. Trong một lần đi chơi công viên \"Miền Nhiệt đới\" với cô bạn từ thuở nhỏ (cũng là bạn gái) Ran Mori , cậu bị dính vào vụ án một hành khách trên Chuyến tàu tốc hành trong công viên, Kishida , bị giết trong một vụ án cắt đầu rùng rợn. Cậu đã làm sáng tỏ vụ án và trên đường về nhà, chứng kiến một vụ làm ăn mờ ám của những người đàn ông mặc toàn đồ đen. Kudo bị phát hiện, bị đánh ngất sau đó những người đàn ông áo đen đã cho cậu uống một thứ thuốc độc chưa qua thử nghiệm là Apotoxin-4869 (APTX4869) với mục đích thủ tiêu cậu. Tuy nhiên chất độc đã không giết chết Kudo. Khi tỉnh lại, cậu bàng hoàng nhận thấy thân thể mình đã bị teo nhỏ trong hình dạng của một cậu học sinh tiểu học....',20000,'Gosho Aoyama',100,'static/images/Conan_tap2.jpg',1),(3,'Conan tập 3','Mở đầu câu truyện, cậu học sinh trung học 16 tuổi Shinichi Kudo bị biến thành cậu bé Conan Edogawa. Shinichi trong phần đầu của Thám tử lừng danh Conan được miêu tả là một thám tử học đường. Trong một lần đi chơi công viên \"Miền Nhiệt đới\" với cô bạn từ thuở nhỏ (cũng là bạn gái) Ran Mori , cậu bị dính vào vụ án một hành khách trên Chuyến tàu tốc hành trong công viên, Kishida , bị giết trong một vụ án cắt đầu rùng rợn. Cậu đã làm sáng tỏ vụ án và trên đường về nhà, chứng kiến một vụ làm ăn mờ ám của những người đàn ông mặc toàn đồ đen. Kudo bị phát hiện, bị đánh ngất sau đó những người đàn ông áo đen đã cho cậu uống một thứ thuốc độc chưa qua thử nghiệm là Apotoxin-4869 (APTX4869) với mục đích thủ tiêu cậu. Tuy nhiên chất độc đã không giết chết Kudo. Khi tỉnh lại, cậu bàng hoàng nhận thấy thân thể mình đã bị teo nhỏ trong hình dạng của một cậu học sinh tiểu học....',20000,'Gosho Aoyama',100,'static/images/Conan_tap3.jpg',1),(4,'Conan tập 4','Mở đầu câu truyện, cậu học sinh trung học 16 tuổi Shinichi Kudo bị biến thành cậu bé Conan Edogawa. Shinichi trong phần đầu của Thám tử lừng danh Conan được miêu tả là một thám tử học đường. Trong một lần đi chơi công viên \"Miền Nhiệt đới\" với cô bạn từ thuở nhỏ (cũng là bạn gái) Ran Mori , cậu bị dính vào vụ án một hành khách trên Chuyến tàu tốc hành trong công viên, Kishida , bị giết trong một vụ án cắt đầu rùng rợn. Cậu đã làm sáng tỏ vụ án và trên đường về nhà, chứng kiến một vụ làm ăn mờ ám của những người đàn ông mặc toàn đồ đen. Kudo bị phát hiện, bị đánh ngất sau đó những người đàn ông áo đen đã cho cậu uống một thứ thuốc độc chưa qua thử nghiệm là Apotoxin-4869 (APTX4869) với mục đích thủ tiêu cậu. Tuy nhiên chất độc đã không giết chết Kudo. Khi tỉnh lại, cậu bàng hoàng nhận thấy thân thể mình đã bị teo nhỏ trong hình dạng của một cậu học sinh tiểu học....',20000,'Gosho Aoyama',100,'static/images/Conan_tap4.jpg',1),(5,'Doraemon tập 1','Đôrêmon là một chú mèo máy được Nôbita, cháu ba đời của Nôbita gửi về quá khứ cho ông mình để giúp đỡ Nôbita tiến bộ, tức là cũng sẽ cải thiện hoàn cảnh của con cháu Nôbita sau này. Còn ở hiện tại, Nôbita là một cậu bé luôn thất bại ở trường học, và sau đó là thất bại trong công việc, đẩy gia đình và con cháu sau này vào cảnh nợ nần. Các câu chuyện trong Đôrêmon thường có một công thức chung, đó là xoay quanh những rắc rối hay xảy ra với cậu bé Nôbita lớp bốn, nhân vật chính thứ nhì của bộ truyện. Đôrêmon có một chiếc túi thần kỳ trước bụng với đủ loại bảo bối của tương lai. Cốt truyện thường gặp nhất sẽ là Nôbita trở về nhà khóc lóc với những rắc rối mà cậu gặp phải ở trường hoặc với bạn bè. Sau khi bị cậu bé van nài hoặc thúc giục, Đôrêmon sẽ đưa ra một bảo bối giúp Nôbita giải quyết những rắc rối của mình, hoặc là để trả đũa hay khoe khoang với bạn bè của cậu. Nôbita sẽ lại thường đi quá xa so với dự định ban đầu của Đôrêmon, thậm chí với những bảo bối mới cậu còn gặp rắc rối lớn hơn trước đó. Đôi khi những người bạn của Nôbita (thường là Xêkô hoặc Chaien) lại lấy trộm những bảo bối và sử dụng chúng không đúng mục đích. Tuy nhiên thường thì ở cuối mỗi câu chuyện, những ai sử dụng sai mục đích bảo bối sẽ phải chịu hậu quả do mình gây ra, và người đọc sẽ rút ra được bài học đạo đức từ đó.',18000,'Fujiko F.Fujio',100,'static/images/Doraemon_tap1.jpg',1),(6,'Doraemon tập 2','Đôrêmon là một chú mèo máy được Nôbita, cháu ba đời của Nôbita gửi về quá khứ cho ông mình để giúp đỡ Nôbita tiến bộ, tức là cũng sẽ cải thiện hoàn cảnh của con cháu Nôbita sau này. Còn ở hiện tại, Nôbita là một cậu bé luôn thất bại ở trường học, và sau đó là thất bại trong công việc, đẩy gia đình và con cháu sau này vào cảnh nợ nần. Các câu chuyện trong Đôrêmon thường có một công thức chung, đó là xoay quanh những rắc rối hay xảy ra với cậu bé Nôbita lớp bốn, nhân vật chính thứ nhì của bộ truyện. Đôrêmon có một chiếc túi thần kỳ trước bụng với đủ loại bảo bối của tương lai. Cốt truyện thường gặp nhất sẽ là Nôbita trở về nhà khóc lóc với những rắc rối mà cậu gặp phải ở trường hoặc với bạn bè. Sau khi bị cậu bé van nài hoặc thúc giục, Đôrêmon sẽ đưa ra một bảo bối giúp Nôbita giải quyết những rắc rối của mình, hoặc là để trả đũa hay khoe khoang với bạn bè của cậu. Nôbita sẽ lại thường đi quá xa so với dự định ban đầu của Đôrêmon, thậm chí với những bảo bối mới cậu còn gặp rắc rối lớn hơn trước đó. Đôi khi những người bạn của Nôbita (thường là Xêkô hoặc Chaien) lại lấy trộm những bảo bối và sử dụng chúng không đúng mục đích. Tuy nhiên thường thì ở cuối mỗi câu chuyện, những ai sử dụng sai mục đích bảo bối sẽ phải chịu hậu quả do mình gây ra, và người đọc sẽ rút ra được bài học đạo đức từ đó.',18000,'Fujiko F.Fujio',100,'static/images/Doraemon_tap2.jpg',1),(7,'Doraemon tập 3','Đôrêmon là một chú mèo máy được Nôbita, cháu ba đời của Nôbita gửi về quá khứ cho ông mình để giúp đỡ Nôbita tiến bộ, tức là cũng sẽ cải thiện hoàn cảnh của con cháu Nôbita sau này. Còn ở hiện tại, Nôbita là một cậu bé luôn thất bại ở trường học, và sau đó là thất bại trong công việc, đẩy gia đình và con cháu sau này vào cảnh nợ nần. Các câu chuyện trong Đôrêmon thường có một công thức chung, đó là xoay quanh những rắc rối hay xảy ra với cậu bé Nôbita lớp bốn, nhân vật chính thứ nhì của bộ truyện. Đôrêmon có một chiếc túi thần kỳ trước bụng với đủ loại bảo bối của tương lai. Cốt truyện thường gặp nhất sẽ là Nôbita trở về nhà khóc lóc với những rắc rối mà cậu gặp phải ở trường hoặc với bạn bè. Sau khi bị cậu bé van nài hoặc thúc giục, Đôrêmon sẽ đưa ra một bảo bối giúp Nôbita giải quyết những rắc rối của mình, hoặc là để trả đũa hay khoe khoang với bạn bè của cậu. Nôbita sẽ lại thường đi quá xa so với dự định ban đầu của Đôrêmon, thậm chí với những bảo bối mới cậu còn gặp rắc rối lớn hơn trước đó. Đôi khi những người bạn của Nôbita (thường là Xêkô hoặc Chaien) lại lấy trộm những bảo bối và sử dụng chúng không đúng mục đích. Tuy nhiên thường thì ở cuối mỗi câu chuyện, những ai sử dụng sai mục đích bảo bối sẽ phải chịu hậu quả do mình gây ra, và người đọc sẽ rút ra được bài học đạo đức từ đó.',18000,'Fujiko F.Fujio',100,'static/images/Doraemon_tap3.jpg',1),(8,'Doraemon tập 4','Đôrêmon là một chú mèo máy được Nôbita, cháu ba đời của Nôbita gửi về quá khứ cho ông mình để giúp đỡ Nôbita tiến bộ, tức là cũng sẽ cải thiện hoàn cảnh của con cháu Nôbita sau này. Còn ở hiện tại, Nôbita là một cậu bé luôn thất bại ở trường học, và sau đó là thất bại trong công việc, đẩy gia đình và con cháu sau này vào cảnh nợ nần. Các câu chuyện trong Đôrêmon thường có một công thức chung, đó là xoay quanh những rắc rối hay xảy ra với cậu bé Nôbita lớp bốn, nhân vật chính thứ nhì của bộ truyện. Đôrêmon có một chiếc túi thần kỳ trước bụng với đủ loại bảo bối của tương lai. Cốt truyện thường gặp nhất sẽ là Nôbita trở về nhà khóc lóc với những rắc rối mà cậu gặp phải ở trường hoặc với bạn bè. Sau khi bị cậu bé van nài hoặc thúc giục, Đôrêmon sẽ đưa ra một bảo bối giúp Nôbita giải quyết những rắc rối của mình, hoặc là để trả đũa hay khoe khoang với bạn bè của cậu. Nôbita sẽ lại thường đi quá xa so với dự định ban đầu của Đôrêmon, thậm chí với những bảo bối mới cậu còn gặp rắc rối lớn hơn trước đó. Đôi khi những người bạn của Nôbita (thường là Xêkô hoặc Chaien) lại lấy trộm những bảo bối và sử dụng chúng không đúng mục đích. Tuy nhiên thường thì ở cuối mỗi câu chuyện, những ai sử dụng sai mục đích bảo bối sẽ phải chịu hậu quả do mình gây ra, và người đọc sẽ rút ra được bài học đạo đức từ đó.',18000,'Fujiko F.Fujio',100,'static/images/Doraemon_tap4.jpg',1),(9,'Naruto tập 1','Naruto là một cậu bé có mơ ước trở thành hokage của làng Konoha,được Hokage phong ấn trong người một trong 9 quái vật của thể giới : Cửu vĩ Hồ ly.Vì cho cậu là một con quái vật, ko ai dám chơi với cậu!& Vì muốn được thừa nhận nên rất phá phách.Khi tốt nghiệp trướng ninja, lần đầu tiên cậu đã được thừa nhận và có một người bạn thân là Sasuke.Hai năm sau, Sasuke đã rời bỏ làng lá để đi theo Orochimaru vì muốn đạt được sức mạnh hơn người, và dùng sức mạnh đó để giết người anh của mình.Naruto muốn đem Sasuke trở về, và vì Kakashi ko đủ trình độ nên đã đi theo Jiraiya - một trong tam nin truyền thuyết của Konoha - để học tập thêm cách dùng sức mạnh.Sau hai năm trờ về, Naruto đã 16 tuổi và có nhiều thay đổi! Và những khó khăn nguy hiểm cũng từ đó tăng lên 2 năm sau Sasuke đã trưởng thành...và đúng với cái tên thiên tài Uchiha cậu đã hạ được Orochimaru ( tất nhiên là lúc hắn đang bị ấn chú của Đệ tam làm yếu nhất ) và phong ấn hắn trong người cậu. Cậu cùng Suigetsu , Juugo và Karin thành lập Mãng xà truy tìm Itachi. Naruto Sakura Choiji Sai Ino Shikamaru Kiba Shino....cũng dần trở thành những ninja mạnh mẽ trụ cột của làng lá. Họ đã hạ được 2 thành viên Akatsuki. Cũng như Sasuke hạ được Deidara Sasuke và Itachi đã gặp nhau. Và trận chiến cuối cùng đã xảy ra với chiến thắng của Sasuke. Madara xuất hiện và sự thật về Itachi đã đc hé lộ...bí mật về Gia tộc Uchiha và Làng Lá đã tạo nên bi kịch giữa Sasuke và Itachi. Nhóm Đại Bàng được thành lập kết hợp cùng Akatsuki chính thức truy tìm 9 quái vật có đuôi và bắt đầu kế hoạch trả thù của Sasuke ..........',22000,'Kishimoto Masashi',100,'static/images/Naruto_tap1.jpg',1),(10,'Naruto tập 2','Naruto là một cậu bé có mơ ước trở thành hokage của làng Konoha,được Hokage phong ấn trong người một trong 9 quái vật của thể giới : Cửu vĩ Hồ ly.Vì cho cậu là một con quái vật, ko ai dám chơi với cậu!& Vì muốn được thừa nhận nên rất phá phách.Khi tốt nghiệp trướng ninja, lần đầu tiên cậu đã được thừa nhận và có một người bạn thân là Sasuke.Hai năm sau, Sasuke đã rời bỏ làng lá để đi theo Orochimaru vì muốn đạt được sức mạnh hơn người, và dùng sức mạnh đó để giết người anh của mình.Naruto muốn đem Sasuke trở về, và vì Kakashi ko đủ trình độ nên đã đi theo Jiraiya - một trong tam nin truyền thuyết của Konoha - để học tập thêm cách dùng sức mạnh.Sau hai năm trờ về, Naruto đã 16 tuổi và có nhiều thay đổi! Và những khó khăn nguy hiểm cũng từ đó tăng lên 2 năm sau Sasuke đã trưởng thành...và đúng với cái tên thiên tài Uchiha cậu đã hạ được Orochimaru ( tất nhiên là lúc hắn đang bị ấn chú của Đệ tam làm yếu nhất ) và phong ấn hắn trong người cậu. Cậu cùng Suigetsu , Juugo và Karin thành lập Mãng xà truy tìm Itachi. Naruto Sakura Choiji Sai Ino Shikamaru Kiba Shino....cũng dần trở thành những ninja mạnh mẽ trụ cột của làng lá. Họ đã hạ được 2 thành viên Akatsuki. Cũng như Sasuke hạ được Deidara Sasuke và Itachi đã gặp nhau. Và trận chiến cuối cùng đã xảy ra với chiến thắng của Sasuke. Madara xuất hiện và sự thật về Itachi đã đc hé lộ...bí mật về Gia tộc Uchiha và Làng Lá đã tạo nên bi kịch giữa Sasuke và Itachi. Nhóm Đại Bàng được thành lập kết hợp cùng Akatsuki chính thức truy tìm 9 quái vật có đuôi và bắt đầu kế hoạch trả thù của Sasuke ..........',22000,'Kishimoto Masashi',100,'static/images/Naruto_tap2.jpg',1),(11,'Naruto tập 3','Naruto là một cậu bé có mơ ước trở thành hokage của làng Konoha,được Hokage phong ấn trong người một trong 9 quái vật của thể giới : Cửu vĩ Hồ ly.Vì cho cậu là một con quái vật, ko ai dám chơi với cậu!& Vì muốn được thừa nhận nên rất phá phách.Khi tốt nghiệp trướng ninja, lần đầu tiên cậu đã được thừa nhận và có một người bạn thân là Sasuke.Hai năm sau, Sasuke đã rời bỏ làng lá để đi theo Orochimaru vì muốn đạt được sức mạnh hơn người, và dùng sức mạnh đó để giết người anh của mình.Naruto muốn đem Sasuke trở về, và vì Kakashi ko đủ trình độ nên đã đi theo Jiraiya - một trong tam nin truyền thuyết của Konoha - để học tập thêm cách dùng sức mạnh.Sau hai năm trờ về, Naruto đã 16 tuổi và có nhiều thay đổi! Và những khó khăn nguy hiểm cũng từ đó tăng lên 2 năm sau Sasuke đã trưởng thành...và đúng với cái tên thiên tài Uchiha cậu đã hạ được Orochimaru ( tất nhiên là lúc hắn đang bị ấn chú của Đệ tam làm yếu nhất ) và phong ấn hắn trong người cậu. Cậu cùng Suigetsu , Juugo và Karin thành lập Mãng xà truy tìm Itachi. Naruto Sakura Choiji Sai Ino Shikamaru Kiba Shino....cũng dần trở thành những ninja mạnh mẽ trụ cột của làng lá. Họ đã hạ được 2 thành viên Akatsuki. Cũng như Sasuke hạ được Deidara Sasuke và Itachi đã gặp nhau. Và trận chiến cuối cùng đã xảy ra với chiến thắng của Sasuke. Madara xuất hiện và sự thật về Itachi đã đc hé lộ...bí mật về Gia tộc Uchiha và Làng Lá đã tạo nên bi kịch giữa Sasuke và Itachi. Nhóm Đại Bàng được thành lập kết hợp cùng Akatsuki chính thức truy tìm 9 quái vật có đuôi và bắt đầu kế hoạch trả thù của Sasuke ..........',22000,'Kishimoto Masashi',100,'static/images/Naruto_tap3.jpg',1),(12,'Naruto tập 4','Naruto là một cậu bé có mơ ước trở thành hokage của làng Konoha,được Hokage phong ấn trong người một trong 9 quái vật của thể giới : Cửu vĩ Hồ ly.Vì cho cậu là một con quái vật, ko ai dám chơi với cậu!& Vì muốn được thừa nhận nên rất phá phách.Khi tốt nghiệp trướng ninja, lần đầu tiên cậu đã được thừa nhận và có một người bạn thân là Sasuke.Hai năm sau, Sasuke đã rời bỏ làng lá để đi theo Orochimaru vì muốn đạt được sức mạnh hơn người, và dùng sức mạnh đó để giết người anh của mình.Naruto muốn đem Sasuke trở về, và vì Kakashi ko đủ trình độ nên đã đi theo Jiraiya - một trong tam nin truyền thuyết của Konoha - để học tập thêm cách dùng sức mạnh.Sau hai năm trờ về, Naruto đã 16 tuổi và có nhiều thay đổi! Và những khó khăn nguy hiểm cũng từ đó tăng lên 2 năm sau Sasuke đã trưởng thành...và đúng với cái tên thiên tài Uchiha cậu đã hạ được Orochimaru ( tất nhiên là lúc hắn đang bị ấn chú của Đệ tam làm yếu nhất ) và phong ấn hắn trong người cậu. Cậu cùng Suigetsu , Juugo và Karin thành lập Mãng xà truy tìm Itachi. Naruto Sakura Choiji Sai Ino Shikamaru Kiba Shino....cũng dần trở thành những ninja mạnh mẽ trụ cột của làng lá. Họ đã hạ được 2 thành viên Akatsuki. Cũng như Sasuke hạ được Deidara Sasuke và Itachi đã gặp nhau. Và trận chiến cuối cùng đã xảy ra với chiến thắng của Sasuke. Madara xuất hiện và sự thật về Itachi đã đc hé lộ...bí mật về Gia tộc Uchiha và Làng Lá đã tạo nên bi kịch giữa Sasuke và Itachi. Nhóm Đại Bàng được thành lập kết hợp cùng Akatsuki chính thức truy tìm 9 quái vật có đuôi và bắt đầu kế hoạch trả thù của Sasuke ..........',22000,'Kishimoto Masashi',100,'static/images/Naruto_tap4.jpg',1),(13,'Biển Và Chim Bói Cá','Biển và  chim bói cá tập trung vào khoảng hai mươi nhân vật, được miêu tả như những hình tượng đa phương, có phần lỏng lẻo như trong một tác phẩm sắp đặt của nghệ thuật thị giác, nói bằng thứ ngôn ngữ trực quan của mồ hôi, nước mắt, máu và cả tiếng thở dài… với vài chục ngàn chi tiết lớn nhỏ, chi tiết nào cũng hóm hỉnh khiến người đọc phải bật cười tức khắc hoặc lay động những cảm giác sâu kín của lòng trắc ẩn, lương tri… Cứ như vậy, những góc khuất của đời sống và con người tại một Liên hiệp đánh cá biển Đông lẫy lừng thành tích và cũng chứa chất những trái ngang… bỗng hiện ra trước bạn đọc như vật chứng không thể chối từ của một thời đại… Có thể xem Bùi Ngọc Tấn là một người kể chuyện thuần theo lối truyền thống, kể bằng sự kiện, nhưng lại không thể nói ông là nhà văn bị lệ thuộc vào hiện thực ở cái vỏ diễn tiến bề ngoài. Ông viết văn như người thiền quán tưởng từng hơi thở, mỗi chi tiết của cuốn sách óng lên một nỗi suy tư day dứt và cả tình cảm mãnh liệt của người viết đối với quê hương, với những nghịch lý thản nhiên đến lạnh lùng của hiện thực vượt khỏi những tiêu chí đạo đức và làm người vẫn được mặc nhiên thừa nhận. Bùi Ngọc Tấn thuộc số người viết văn để nhắc ta một cái quyền, quyền được sâu sắc.',75000,'Bùi Ngọc Tấn',100,'static/images/bienvachimboica.jpg',2),(14,'Bí Mật Hậu Cung',' Nhà văn Bùi Anh Tấn đã trở lại với đế tài đồng tình trong “Bí mật hậu cung”, tiểu thuyết viết về vương triều nhà Lý.Vào thế kỷ thứ XI, trong cuộc kháng chiến chống quân Tống xâm lược, những nhân vật có thật và hư cấu được lồng vào không khí võ thuật huyền ảo. Trong đó Ngô Thuấn, danh tướng kiệt xuất được tác giả xây dựng từ nhân vật lịch sử Lý Thường Kiệt, có sức sống mạnh mẽ và ly kỳ hấp dẫn. Với tổ quốc họ là người hùng, với đời sống cá nhân họ phải đối diện với những dằn vặt về giới tính cùng những bí mật không biết tỏ cùng ai.  Cùng với việc tái hiện một giai đoạn lịch sử đấu tranh giữ nước oai hùng của dân tộc, tác giả đã lột tả được tính cách, nỗi đau số phận của những anh hùng võ nghệ vô song. Dù có ở đỉnh cao họ vẫn cần sự chia sẻ và đồng cảm…',85000,'Bùi Anh Tấn',100,'static/images/bimathaucung.jpg',2),(15,'Con Đường Đêm','Lao công đào binh- đó là cách gọi những người lính nguỵ phản chiến, bị bắt, bị giam cầm, đầy ải, bị đẩy ra chiến trường làm những việc hèn mạt nhất- Chiến tranh đối với họ còn khủng khiếp gấp trǎm lần. Những nhân vật tác giả miêu tả trong cuốn con đường đêm hầu như là những người có thật, đã cùng tác giả- cũng là một nhân vật- sống những ngày như trong địa ngục. Tất cả những con người phản đối cuộc chiến tranh phi nghĩa mà những kẻ chống lại nhân dân theo đuổi, dù bị đầy ải, vẫn một lòng hy vọng về ngày mai tươi sáng- Hành động tích cực sau cùng của họ là vượt qua hàng rào giam cầm, tìm về phía ánh sáng- Con đường họ đi cũng đầy chết chóc. Nhưng họ đã gọi thân phận họ, lao công đào binh, LCĐB, bằng tên khác. Loài chim đi biển- và những trang cuối của cuốn tiểu thuyết cũng có ánh sáng.',21000,'Nguyễn Hoàng Thu',100,'static/images/conduongdem.jpg',2),(16,'Vọng','Gã trai tên Tụ, tìm lại hình ảnh người cha mất tích qua lời kể của một người bạn của gia đình cùng những ký ức mơ hồ của chính gã. Trên cuộc tìm kiếm vô vọng, gã gặp lại cô bạn gái cũ trong hình hài người đàn bà đang bị ức hiếp bởi một nhóm lâm tặc.     Câu chuyện là những mảnh ghép trần trụi, phơi bày thói đạo đức giả, sự vô cảm và hèn hạ, nó như lời cảnh báo về sự hủy diệt – không chỉ là sự hủy diệt của chiến tranh; sự khốc liệt mang tính hủy diệt ấy còn thể hiện qua những mảng tối của cuộc sống đương đại. Nhà văn trẻ Nguyễn Mạnh Hùng cho thấy anh khá nhạy cảm với các vấn đề xã hội, những vấn đề mà ta chứng kiến hoặc nghe thấy hàng ngày qua các bản tin thời sự trên báo đài và internet.   Có thể nói tiểu thuyết “VỌNG” dự báo tương lai đầy hứa hẹn của một nhà văn trẻ.',46000,'Nguyễn Mạnh Hùng',100,'static/images/vong.jpg',2),(17,'Mong Manh','Thanh và Liên Khê học cùng lớp. Ngoài việc luôn cùng đại diện lớp tham gia các buổi sinh hoạt văn nghệ ở trường, hai cô cậu còn rất quan tâm và thân thiết với nhau. Không quân Mỹ leo thang chiến tranh ra miền Bắc, trường học ở thủ đô phải tạm đóng cửa, học sinh sơ tán về các vùng quê tiếp tục học tập, Thanh và Liên Khê phải xa nhau. Bất chấp những nỗ lực của hai cô cậu để giữ liên lạc, mẹ Liên Khê đang có kế hoạch riêng với cuộc đời cô bé. Rung động đầu đời hồn nhiên, trong trẻo bị thẳng tay vùi dập. Cuốn tiểu thuyết phản ánh rõ nét tinh thần của một thời kì khi toàn dân vừa kiên cường chống đế quốc Mỹ xâm lược vừa hăng say lao động xây dựng chủ nghĩa xã hội. Đan xen giữa những dòng kể chuyện duyên dáng, nhiều thông tin, là những lá thư, những dòng nhật kí của những người phải xa nhau, đầy thương nhớ nhưng cũng rất cao thượng, nghĩ đến mình nhưng cũng rất biết vì những điều cao cả hơn. Một cuốn tiểu thuyết đầy đặn, xúc động, giàu tính nhân văn, thể hiện sâu sắc ý thức về sự “mong manh” của tình yêu, của phận người trong chiến tranh.',66000,'Nguyễn Ngọc Tiến ',100,'static/images/mongmanh.jpg',2),(18,'Gần Như Là Sống','Đây là cuốn tỉêu thuyết đầu tiên Đỗ Phấn dùng ngôi thứ nhất - “tôi”. Song không khác các cuốn khác là tác giả vẫn viết về Hà Nội, thành phố nơi anh sinh ra, lớn lên, chứng kiến những đổi thay từ hình hài đến giọng nói người, đến món ăn, cách người ta sống, làm việc, và yêu nhau.  Câu chuyện được dẫn dắt theo một giọng kể. Thành, một kiến trúc sư thôi làm công chức sở quy hoạch chuyển qua làm họa sĩ tự do. Vẽ tranh, có tiền, có bạn bè và những cuộc tình đều nồng nàn dù sâu đậm hay thoảng qua, nhưng sao không thấy vui... Có lẽ bởi ở những gì anh nhìn thấy.',80000,'Đỗ Phấn',100,'static/images/gannhulasong.jpg',2),(19,'Ngồi','Ngồi là cuốn tiểu thuyết có bút pháp độc đáo, mới mẻ không được viết theo lối tiểu thuyết truyền thống. Tiểu thuyết pha trộn giữa hiện thực với tưởng tượng. Nhân vật chính của cuốn sách đồng thời sống trong hai thế giới, một thế giới có thể tạm coi là hiện tại của anh ta (đi đến văn phòng một công sở, sống với những người đồng nghiệp và những người bạn, cuộc sống nửa vợ chồng, nửa tạm bợ của anh ta với cô gái Minh…) và một thế giới của một cái gì đó, nửa như giấc mơ, nửa như quá khứ (mối tình của anh ta và cô gái Kim). Điều kỳ lạ là trong đời sống của nhân vật giữa hai thế giới đó luôn có sự giao tiếp. Đây là một trong số tác phẩm thành công nhất của nhà văn Nguyễn Bình Phương. Cuốn sách đã từng gây xôn xao dư luận, thu hút sự quan tâm đặc biệt của bạn đọc và giới sáng tác, phê bình. Sách dành cho bạn đọc yêu thích văn chương, đặc biệt ở lứa tuổi trung niên, cao niên.',63000,'Nguyễn Bình Phương',100,'static/images/ngoi.jpg',2),(20,'Lụa','Nước Pháp, 1861. Khi một dịch bệnh đe doạ xoá sạch việc buôn bán lụa ở Pháp quốc, Herve Joncour, một chàng nuôi tằm trẻ tuổi, đã phải vượt qua những châu lục xa xôi để đến Nhật Bản, vốn bế quan toả cảng với những kẻ ngoại quốc, để mua cho được giống tằm khoẻ mạnh. Trong những cuộc điều đình bí mật với một ông trùm địa phương. Joncour đã bị hớp hồn bởi người thiếp của ông ta, một thiếu phụ có đôi mắt không chút nào phương Đông. Cho dù họ không thể trao đổi với nhau bất kỳ điều gì kể cả một hai lời nói, tình yêu đã bừng nở giữa họ, một mối tình được chuyên chở bằng những thông điệp khó hiểu. Mối tình bí mật của họ phát triển ra sao được kể trong câu chuyện tình xuất sắc này. Ám ảnh như một khúc nhạc mê đắm, Lụa chính là một câu chuyện được bỏ bùa mê, một khúc trần thuật tinh tế và một thành tựu về phong cách.  Lụa, tác phẩm trứ danh của Alessandro Baricco, nhà văn Ý đương đại nổi tiếng, là tác phẩm Bestseller trên toàn châu Âu. Lụa đã được chuyển ngữ sang trên 30 thứ tiếng.',22000,'Alessandro Baricco',100,'static/images/lua.jpg',2),(21,'Hương Vị Đồng Xanh','Hương Vị Đồng Xanh – hương vị của trái tim – ngọt ngào và ấm áp như cơn gió phảng phất một ngày hạ oi bức. thổi vào đó bao nhiêu hy vọng tươi sang về một chuyện tình đẹp nên thơ. Câu chuyện chất chứa sự gần gũi, bình dị nhưng vô cùng sâu lắng, cũng nhen đầy nỗi đau khiến long ta se thắt... Dù vậy, có đau thương, có nước mắt song như chính bức tranh vẽ lên đồng xanh yêu thương ấy... mỗi màu đều là một nét chấm phá diệu kỳ.',93000,'Born',100,'static/images/huongvidongxanh.jpg',2),(22,'Ba Chàng Ngốc','Bạn muốn biết cách luyện thi vào một trường đại học hạng nhất? Ôi thôi đi, dễ chừng một nửa số cây trên thế giới đã bị đốn để in các loại sách có khi đều đáng vứt vào sọt rác rồi còn gì. Bạn muốn một cuốn cẩm nang dạy cách sống sót qua những năm đại học? Thế cũng thôi đi, đến chúng tôi còn chẳng hiểu làm sao có thể gắng gượng được đến phút cuối nữa là.     Còn nếu các bạn muốn tìm một tấm gương tày liếp về sự sa ngã nơi giảng đường một khi bạn không biết suy nghĩ cho tử tế, thì đây, câu chuyện về chúng tôi - ba ngôi sao thời trung học nhưng lại thành ra Ba chàng ngốc đì đẹt điểm trung bình ngày đại học với đủ trò quậy phá, gian lận, và cũng là Ba chàng ngốc luôn sát cánh bên nhau nếm trải nào tình bạn khắc cốt ghi tâm, nào tình yêu vượt qua mọi rào cản, nào tình thầy trò sáng trong thân thiết, nào tình  cảm gia đình sẵn sàng xả thân.     Và, có thể bạn đã biết, năm 2009, câu chuyện về chúng tôi đã được đạo diễn Rajkumar Hirani chuyển thể thành Ba chàng ngốc - bộ phim Bollywood phá mọi kỷ lục phòng vé để trở thành bộ phim ăn khách nhất lịch sử Ấn Độ.      Còn bây giờ, nào, hãy cùng chúng tôi trải nghiệm những năm tháng tuổi trẻ điên rồ nổi loạn!',66000,'Chetan Bhagat',100,'static/images/bachangngoc.jpg',2),(23,'Lễ Hội Của Vô Nghĩa','Làm sáng tỏ những vấn đề nghiêm túc nhất mà không hề dùng một câu đao to búa lớn, luôn cuốn theo hiện thực thế giới đương thời, nhưng đồng thời xa lánh chủ nghĩa hiện thực. Đó chính là “Lễ Hội Của Vô Nghĩa”.    Đưa một phần “không-nghiêm-túc” vào tiểu thuyết, hẳn điều đó không còn là bất ngờ đối với những ai từng đọc các tác phẩm trước của Kundera. Chỉ có một câu để nói về cuốn sách này: Hãy đọc nó!',42000,'Milan Kundera',100,'static/images/lehoivonghia.jpg',2),(24,'Mùa Xa Nhà','Mùa xa nhà là cuốn tiều thuyết kể lại giai đoạn làm lính tình nguyện của Huy, chàng trai thành phố đi nghĩa vụ quân sự, có mặt và sống chiến đấu ở một đơn vị hỏa lực bộ binh trong những năm giữa thập niên 80 thế kỷ 20 ở vùng rừng phía Tây Bắc Campuchia xa xôi.   Từ một chàng trai thư sinh, Huy đã dần quen với cuộc sống. Ở đó Huy không chỉ làm quen với nhiều chàng trai thành phố khác nhập ngũ trước mình, mà còn bè bạn và chịu sự chỉ huy của những chàng trai từ khắp miền Tổ quốc làm nhiệm vụ lính tình nguyện ở Campuchia.   Những vui buồn, hờn giận, những mất mát đau thương, cả những trận chiến đấu nẩy lửa… cứ từng bước tôi cho chàng lính trẻ lần đầu tiên xa nhà trải qua 3 năm chiến trận trở thành một cán bộ trung đội rắn rõi và đầy bản lĩnh. Anh yên lành trở về thành phố, kết thúc mùa xa nhà của đời lính trong sự thay đổi đến ngỡ ngàng.',68000,'Nguyễn Thành Nhân  ',100,'static/images/muaxanha.jpg',2),(25,'Kẻ Móc Túi','Một gã trai sống lang bạt ở Tokyo bằng tài móc túi thiên bẩm: móc túi thuận cả hai tay. Gã với tay móc mọi thứ của người khác nhưng lại quay lưng với thế giới. Một ngày, tay trùm Yazuka bắt gã thực hiện ba phi vụ “nhỏ”: lấy trộm điện thoại di động của một người đàn ông; lấy một vật nhỏ có dính vân tay của một người đàn ông khác kèm theo vài sợi tóc của hắn; đánh tráo tập tài liệu mà một người đàn ông luôn mang theo bên người sao cho ít nhất hai ngày sau hắn mới phát hiện ra.     Hai phi vụ đầu được gã thực hiện suôn sẻ, cho tới phi vụ cuối cùng… Và số phận hai mẹ con cô gái điếm mới quen đột nhiên nằm trong tay gã…     Giữa sự sống và cái chết, ánh sáng bất ngờ soi rọi lên cuộc đời kẻ móc túi…',55000,'Nakamura Fuminori',100,'static/images/kemoctui.jpg',3),(26,'Tội Lỗi Không Chứng Cứ','Sát thủ liên hoàn, dàn dựng hiện trường vụ án, hắn nói giết người là để cứu người, bạn có tin không? Phía sau hành vi tội ác máu lạnh, lại là một trái tim bị tình yêu và nỗi hận thù giày vò suốt gần mười năm qua.  Chốn đô thị phồn hoa liên tiếp xảy ra những vụ án mạng. Tại hiện trường vụ án, hung thủ luôn cố ý để lại dấu vân tay và một tờ giấy ghi “Hãy đến bắt ta’. Ngoài ra, không có chút sơ hở hay manh nối nào cả.  Đối diện với tên sát thủ liên hoàn huênh hoang như vậy, tổ chuyên án được thành lập bốn lần nhưng đều phải giải tán, không có chút manh mối nào, chỉ có thể nhờ đến vị chuyên gia logic học Ngiêm Lương. Vụ án này bí ẩn giống như một hệ phương trình không có cách giải, liệu ông phải bắt tay từ đâu để tìm ra lời giải?  Hung thủ thực sự đã tỉ mỉ sắp xếp vụ án phạm tội không có chứng cứ, tại sao lại cố tình để lại manh mối? Đây là một âm mưu to lớn hay là một cái bẫy, cũng có thể là một bí mật được cất giấu rất kỹ không ai hay biết?',106000,'Tử Kim Trần',94,'static/images/toiloikhongchungcu.jpg',3),(27,'Bão Cát','Cuộc tìm kiếm một thành phố với hàng ngàn cây cột bằng thủy tinh bị vùi sâu trong lòng sa mạc A-rập, một thế giới chưa bao giờ được hình dung đã từng tồn tại, nơi chứa đựng những điều thật đáng kinh ngạc.     Tất cả bắt đầu từ một vụ nổ lớn tại bảo tàng Anh ở London. Một trái tim nằm trong pho tượng bằng sắt bị nung đến nóng chảy tại đây chứa đựng lời giải đáp đầu tiên cho câu hỏi vị trí của thành phố nằm ở đâu.     Painter Crowe là một nhân viên của lực lượng Sigma, một tổ chức bí mật làm việc cho Bộ Quốc phòng Mỹ, có nhiệm vụ đảm bảo an toàn cho các phát minh khoa học khỏi sự nhòm ngó của các thế lực thù địch. Khi những dấu vết khảo cổ dẫn tới một huyền thoại “Đại Tây Dương trong lòng cát”, Painter phải sang Anh, từ đó bắt đầu tới thế giới A-rập thực thi nhiệm vụ tìm kiếm thành phố mất tích và nguồn sức mạnh hủy diệt vượt xa ngoài tưởng tượng của con người.     Nhưng Painter đã gặp phải những đối thủ. Một nhóm những kẻ đánh thuê tàn nhẫn do một người bạn, một đồng sự của anh trước đây chỉ huy có cùng một mục đích với Painter và sẵn sàng hủy diệt bất cứ ai cản đường chúng.     Lịch sử khảo cổ “va phải” một nền khoa học với những phát minh tân tiến nhất có khả năng đe dọa sự an toàn của thế giới.',125000,'James Rollins',96,'static/images/baocat.jpg',3),(28,'Bích Ngọc','Càng lúc càng hoang mang về sứ mệnh thật sự của Hồng Ngọc trong Vòng tròn Thập nhị, Gwendolyn Shepherdsành điệu ở thế kỷ 21 đã hơn một lầnliều lĩnh độc hành về quá khứ để gặp gỡ ông ngoại trẻ tuổi.Những manh mối hé dần chân tướng một âm mưu bí mật, khiến Gwen và những người ủng hộ cực kỳ bận rộn, kể cả Xemerius, dù nó không phảilà người mà là một con quỷ đá vô hình tinh ranh.     Và Gwen, với những nghĩ ngờ vực xoắn vặn trong não, vẫn tiếp tục song hành cùng Gideon đẹp trai chết người hồi khứ vềcác vũ hội huy hoàng thế kỷ 19, rồi ghen tuông, rồi cãi vã, vướng vào cuộc truy sát mất mạng. Cô có hồi sinh… hay không hồi sinh? Từ nút thắt thót tim này sẽ dẫn đến một hồi kết vô cùng kỳ lạ…     Bích Ngọc đã khép lại Timeless! Tất cả các bà mẹ đều say mê Kerstin Gier, giờ thì con gái họ cũng vậy....',85000,'Kerstin Gier',97,'static/images/bichngoc.jpg',3);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Truyện'),(2,'Tiểu thuyết'),(3,'Trinh thám');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_book`
--

DROP TABLE IF EXISTS `import_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_book` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_book`
--

LOCK TABLES `import_book` WRITE;
/*!40000 ALTER TABLE `import_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_book_detail`
--

DROP TABLE IF EXISTS `import_book_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_book_detail` (
  `import_book_id` int NOT NULL,
  `book_id` int NOT NULL,
  `book_amount` int NOT NULL,
  PRIMARY KEY (`import_book_id`,`book_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `import_book_detail_ibfk_1` FOREIGN KEY (`import_book_id`) REFERENCES `import_book` (`id`),
  CONSTRAINT `import_book_detail_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_book_detail`
--

LOCK TABLES `import_book_detail` WRITE;
/*!40000 ALTER TABLE `import_book_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_book_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_rule`
--

DROP TABLE IF EXISTS `manager_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_rule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `min_import` int NOT NULL,
  `min_amount` int NOT NULL,
  `max_debt` float NOT NULL,
  `min_amount_after` int NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `manager_rule_chk_1` CHECK ((`active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_rule`
--

LOCK TABLES `manager_rule` WRITE;
/*!40000 ALTER TABLE `manager_rule` DISABLE KEYS */;
INSERT INTO `manager_rule` VALUES (1,150,300,500000,20,1);
/*!40000 ALTER TABLE `manager_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `bill_id` int NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `delivery` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `cmnd` varchar(50) DEFAULT NULL,
  `UserRole` enum('User','Employee','Manager') DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_chk_1` CHECK ((`active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Thành',1,'static/images/upload/avatar.png','manager','202cb962ac59075b964b07152d234b70','ctthanh2911@gmail.com','','','','Manager'),(2,'Tựu',1,'static/images/upload/avatar.png','employee','202cb962ac59075b964b07152d234b70','thientuu2911@gmail.com',NULL,NULL,NULL,'Employee'),(3,'Tựu',1,'static/images/upload/avatar.png','user','202cb962ac59075b964b07152d234b70','thientuu29111@gmail.com',NULL,NULL,NULL,'User');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-17  2:34:51
