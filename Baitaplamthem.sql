USE master
GO
CREATE DATABASE BTLamThem
GO

USE BTLamThem

GO


CREATE TABLE KHACHHANG 
(
    MaKH CHAR(6) NOT NULL PRIMARY KEY,
    TenKH NVARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    SoDT CHAR(11) NOT NULL UNIQUE,
    DiaChi NVARCHAR(100) NOT NULL
)
GO 

CREATE TABLE DMSANPHAM 

(
    MaDM CHAR(6) NOT NULL PRIMARY KEY,
    TenDM NVARCHAR(50) NOT NULL,
    MoTa NVARCHAR(200) NULL
)
GO 

DROP TABLE DMSANPHAM

CREATE TABLE SANPHAM 
(
    MaSP CHAR(6) NOT NULL PRIMARY KEY,
    MaDM CHAR(6) NOT NULL,
    TenSP NVARCHAR(100) NOT NULL,
    SoLuong SMALLINT NOT NULL CHECK(SoLuong >=0),
    GiaTien FLOAT,
    XuatXu CHAR(100) NOT NULL,
    FOREIGN KEY(MaDM) REFERENCES DMSANPHAM(MaDM)
) 
GO 

DROP TABLE SANPHAM

CREATE TABLE THANHTOAN
(
    MaTT CHAR(6) NOT NULL PRIMARY KEY,
    PhuongThucTT NVARCHAR(20) NOT NULL
)

CREATE TABLE DONHANG
(
    MaDH CHAR(6) NOT NULL PRIMARY KEY,
    MaKH CHAR(6) NOT NULL,
    MaTT CHAR(6) NOT NULL,
    NgayDat DATE NOT NULL,
    FOREIGN KEY(MaKH) REFERENCES KHACHHANG(MaKH),
    FOREIGN KEY(MaTT) REFERENCES THANHTOAN(MaTT)
)

CREATE TABLE CHITIETDONHANG 
(
    MaDH CHAR(6) NOT NULL,
    MaSP CHAR(6) NOT NULL,
    SoLuong SMALLINT NOT NULL CHECK(SoLuong >=0),
    TongTien MONEY NOT NULL CHECK(TongTien >0),
    CONSTRAINT PK_CTDH PRIMARY KEY(MaDH, MaSP),
    FOREIGN KEY(MaDH) REFERENCES DONHANG(MaDH),
    FOREIGN KEY(MaSP) REFERENCES SANPHAM(MaSP)
)
GO 




INSERT KHACHHANG VALUES 
('KH001','Tran Van An','antv@gmail.com','0905123564','Lang Son'),
('KH002','Phan Phuoc','phuocp@gmail.com','0932568984','Da Nang'),
('KH003','Tran Huu Anh','anhth@gmail.com','0901865232', 'Ha Noi')

INSERT DMSANPHAM VALUES
('DM01','Thoi Trang Nu', 'vay, ao danh cho nu'),
('DM02', 'Thoi Trang Nam', 'quan danh cho nam'),
('DM03','Trang suc', 'danh cho nu va nam')

INSERT SANPHAM VALUES
('SP001','DM01', 'Dam Maxi', 200, 195000,'VN'),
('SP002', 'DM01', 'Tui Da Mỹ', 50, 3000000, 'HK'),
('SP003', 'DM02', 'Lac tay Uc', 300, 300000, 'HQ')

INSERT THANHTOAN VALUES
('TT01', 'Visa'),
('TT02', 'Master Card'),
('TT03','JCB')

INSERT DONHANG VALUES
('DH001', 'KH002', 'TT01', '2014/10/20'),
('DH002','KH002','TT01', '2015/05/15'),
('DH003', 'KH001','TT03', '2015/04/02')

INSERT CHITIETDONHANG VALUES
('DH001', 'SP002', 3, 56000),
('DH003', 'SP001', 10, 7444),
('DH002', 'SP002', 10, 67144)

-- Câu 1: Liệt kê thông tin toàn bộ Sản phẩm.
Select * from SANPHAM

--Cau 2: Xóa toàn bộ khách hàng có DiaChi là 'Lang Son'.
DELETE FROM KHACHHANG WHERE DiaChi = 'Lang Son'

-- Câu 3: Cập nhật giá trị của trường XuatXu trong bảng SanPham thành 'Viet Nam' đối với trường XuatXu có giá trị là 'VN'.
UPDATE SANPHAM SET XuatXu = 'Viet Nam' WHERE XuatXu = 'VN'

--Câu 4: Liệt kê thông tin những sản phẩm có SoLuong lớn hơn 50 thuộc danh mục là 'Thoi trang nu' và 
-- những Sản phẩm có SoLuong lớn hơn 100 thuộc danh mục là 'Thoi trang nam'.
SELECT * FROM SANPHAM S 
INNER JOIN DMSANPHAM DM 
ON DM.MaDM = S.MaDM 
WHERE (S.SoLuong > 50 AND DM.TenDM = N'Thoi trang nu') 
OR (S.SoLuong > 100 AND DM.TenDM = N'Thoi trang nam')

--Câu 5: Liệt kê những khách hàng có tên bắt đầu là ký tự 'A' và có độ dài là 5 ký tự.
SELECT * FROM KHACHHANG WHERE TenKH LIKE 'A%' AND LEN(TenKH) = 5

-- Câu 6: Liệt kê toàn bộ Sản phẩm, sắp xếp giảm dần theo TenSP và tăng dần theo SoLuong.
SELECT * FROM SANPHAM ORDER BY TenSP DESC, SoLuong ASC

-- Câu 7 Đếm các sản phẩm tương ứng theo từng khách hàng đã đặt hàng, chỉ đếm những Sản phẩm được khách hang đặt hàng trên 5 sản phẩm.
SELECT K.TenKH ,S.TenSP, SUM(S.SoLuong) AS SoLuong 
FROM KHACHHANG K INNER JOIN DONHANG D
 ON D.MaKH = K.MaKH INNER JOIN CHITIETDONHANG CT
 ON CT.MaDH = D.MaDH INNER JOIN SANPHAM S
 ON S.MaSP = CT.MaSP GROUP BY K.TenKH, S.TenSP
 HAVING COUNT(CT.SoLuong)>5

-- Câu 8: Liệt kê tên của toàn bộ khách hàng (tên nào giống nhau thì chỉ liệt kê một lần).
SELECT DISTINCT TenKH FROM KHACHHANG

-- Câu 9: Liệt kê MaKH, TenKH, TenSP, SoLuong, NgayDat, GiaTien,TongTien (của tất cả các lần đặt hàng của khách hàng).
SELECT K.MaKH, K.TenKH, S.TenSP, S.SoLuong, D.NgayDat, S.GiaTien, CT.TongTien 
FROM KHACHHANG K INNER JOIN DONHANG D 
ON D.MaKH = K.MaKH INNER JOIN CHITIETDONHANG CT 
ON CT.MaDH = D.MaDH INNER JOIN SANPHAM S 
ON S.MaSP = CT.MaSP

-- Câu 10: Liệt kê MaKH, TenKH, MaDH, TenSP, SoLuong, TongTien của tất cả các lần đặt hàng của khách hàng.
SELECT K.MaKH, K.TenKH, S.TenSP, S.SoLuong, D.NgayDat, S.GiaTien, CT.TongTien 
FROM KHACHHANG K 
INNER JOIN DONHANG D ON D.MaKH = K.MaKH 
INNER JOIN CHITIETDONHANG CT ON CT.MaDH = D.MaDH 
INNER JOIN SANPHAM S ON S.MaSP = CT.MaSP

-- Câu 11: Liệt kê MaKH, TenKH của những khách hàng đã từng đặt hàng với thực hiện thanh toán qua 'Visa' hoặc đã thực hiện thanh toán qua 'JCB'.
SELECT K.MaKH, K.TenKH 
FROM KHACHHANG K INNER JOIN DONHANG D 
ON D.MaKH = K.MaKH  
INNER JOIN THANHTOAN T ON T.MaTT = D.MaTT
WHERE T.PhuongThucTT = 'JCB' OR T.PhuongThucTT = 'Visa'

-- Câu 12: Liệt kê MaKH, TenKH của những khách hàng chưa từng mua bất kỳ sản phẩm nào.
SELECT K.MaKH , K.TenKH FROM KHACHHANG K WHERE K.TenKH NOT IN (
SELECT K.TenKH
FROM KHACHHANG K 
INNER JOIN DONHANG D 
ON D.MaKH = K.MaKH 
)

/*Câu 13: Liệt kê MaKH, TenKH, TenSP, SoLuong, GiaTien, PhuongThuc TT, NgayDat, 
 Tong Tien của những Khách hàng có địa chỉ là 'Da Nang' 
 và mới thực hiện đặt hàng một lần duy nhất. Kết quả liệt kê được sắp xếp tăng dần của trường TenKH.
 */
SELECT K.MaKH, K.TenKH, S.TenSP, S.GiaTien, T.PhuongThucTT, D.NgayDat, CT.TongTien 
FROM KHACHHANG K INNER JOIN DONHANG D 
ON D.MaKH = K.MaKH INNER JOIN CHITIETDONHANG CT
ON CT.MaDH = D.MaDH INNER JOIN SANPHAM S 
ON S.MaSP = CT.MaSP INNER JOIN THANHTOAN T ON T.MaTT = D.MaTT WHERE K.MaKH IN (
SELECT K.MaKH 
FROM KHACHHANG K INNER JOIN DONHANG D 
ON D.MaKH = K.MaKH  
GROUP BY K.MaKH HAVING COUNT(K.MaKH) = 1
) ORDER BY K.TenKH

