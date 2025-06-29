CREATE DATABASE IF NOT EXISTS management_banhxeo;
USE management_banhxeo;

CREATE TABLE users (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) UNIQUE NOT NULL,
                       password VARCHAR(100) NOT NULL,
                       role ENUM('ADMIN', 'USER') DEFAULT 'USER',
                       email VARCHAR(100) UNIQUE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menu (
                      menu_id INT AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(100) NOT NULL,
                      price DECIMAL(10, 2) NOT NULL,
                      image_url VARCHAR(255), -- Lưu đường dẫn ảnh sau khi upload
                      likes INT DEFAULT 0,
                      category VARCHAR(50) -- Thêm cột danh mục
);

CREATE TABLE orders (
                        order_id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT,
                        total_amount DECIMAL(10, 2) NOT NULL,
                        status ENUM('PENDING', 'APPROVED', 'CANCELLED') DEFAULT 'PENDING',
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_details (
                               order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
                               order_id INT,
                               menu_id INT,
                               quantity INT NOT NULL,
                               price DECIMAL(10, 2) NOT NULL,
                               FOREIGN KEY (order_id) REFERENCES orders(order_id),
                               FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

CREATE TABLE cart (
                      cart_id INT AUTO_INCREMENT PRIMARY KEY,
                      user_id INT,
                      menu_id INT,
                      quantity INT NOT NULL,
                      FOREIGN KEY (user_id) REFERENCES users(user_id),
                      FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);
ALTER TABLE order_details
DROP FOREIGN KEY order_details_ibfk_2;

ALTER TABLE order_details
    ADD CONSTRAINT order_details_ibfk_2
        FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE;

ALTER TABLE orders ADD COLUMN note VARCHAR(255);
ALTER TABLE orders MODIFY COLUMN status VARCHAR(20);

ALTER TABLE menu ADD created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

DESCRIBE orders;


-- Cập nhật dữ liệu menu với danh mục
INSERT INTO menu (name, price, image_url, category) VALUES
                                                        ('Bánh Xèo Tôm Nhảy', 35000, 'banhxeo_tom.jpg', 'Bánh Xèo'),
                                                        ('Bánh Xèo Bò', 35000, 'banhxeo_bo.jpg', 'Bánh Xèo'),
                                                        ('Bánh Xèo Mực', 35000, 'banhxeo_muc.jpg', 'Bánh Xèo'),
                                                        ('Bánh Xèo Trứng', 20000, 'banhxeo_trung.jpg', 'Bánh Xèo'),
                                                        ('Chả Ram Tôm Đất', 60000, 'charam_tomdat.jpg', 'Khác'),
                                                        ('Chả Cây', 8000, 'chacay.jpg', 'Khác'),
                                                        ('Nem', 6000, 'nem.jpg', 'Khác'),
                                                        ('Yến Chưng - Hạt Sen', 100000, 'yenchung_hatsen.jpg', 'Khác'),
                                                        ('Yến Chưng - Hạt Chia', 100000, 'yenchung_hatchia.jpg', 'Khác'),
                                                        ('Yến Chưng - Táo Đỏ', 100000, 'yenchung_taodo.jpg', 'Khác'),
                                                        ('Cám Vắt Dưa Tươi', 25000, 'camvat_duatuoi.jpg', 'Nước Uống'),
                                                        ('Cám Vắt Thơm', 25000, 'camvat_thom.jpg', 'Nước Uống'),
                                                        ('Cám Vắt Ổi', 25000, 'camvat_oi.jpg', 'Nước Uống'),
                                                        ('Cám Vắt Dưa Hấu', 20000, 'camvat_duahau.jpg', 'Nước Uống'),
                                                        ('Pepsi', 15000, 'pepsi.jpg', 'Nước Uống'),
                                                        ('Coca', 15000, 'coca.jpg', 'Nước Uống'),
                                                        ('7 Up', 15000, '7up.jpg', 'Nước Uống'),
                                                        ('Bò Húc', 20000, 'bohuc.jpg', 'Nước Uống'),
                                                        ('Sting', 15000, 'sting.jpg', 'Nước Uống'),
                                                        ('Lavie', 10000, 'lavie.jpg', 'Nước Uống'),
                                                        ('Revive Chồng Đường', 15000, 'revive.jpg', 'Nước Uống'),
                                                        ('Nước Khoáng Vinh Hảo', 15000, 'nuockhoang_vinhhao.jpg', 'Nước Uống'),
                                                        ('Tiger', 25000, 'tiger.jpg', 'Nước Uống'),
                                                        ('Heineken Silver', 35000, 'heineken_silver.jpg', 'Nước Uống'),
                                                        ('Khăn Lạnh', 2000, 'khanlanh.jpg', 'Khác');

-- Insert admin account
INSERT INTO users (username, password, role, email) VALUES ('admin', 'admin123', 'ADMIN', 'admin@example.com');