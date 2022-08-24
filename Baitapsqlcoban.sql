CREATE DATABASE SQLBasic
GO

USE SQLBasic

GO

CREATE TABLE LoaiSP 
(
    MaLoaiSP VARCHAR(6) NOT NULL PRIMARY KEY,
    TenLoaiSP NVARCHAR(50) NOT NULL
)
GO 


CREATE TABLE SanPham 
(
    MaSP VARCHAR(6) NOT NULL PRIMARY KEY,
    TenSP NVARCHAR(50) NOT NULL,
    MaLoaiSP VARCHAR(6) NOT NULL
	CONSTRAINT FK_LoaiSP FOREIGN KEY(MaLoaiSP) REFERENCES LoaiSP(MaLoaiSP),
    GiaBan FLOAT NOT NULL CHECK(GiaBan > 0)
)
GO 



CREATE TABLE NhanVien 
(
    MaNV VARCHAR(6) NOT NULL PRIMARY KEY,
    HoTenNV NVARCHAR(50) NOT NULL,
    GioiTinh BIT NOT NULL,
    QueQuan NVARCHAR(50),
    Tuoi SMALLINT NOT NULL
)
GO 



CREATE TABLE BanHang 
(
    MaSP VARCHAR(6) NOT NULL,
    MaNV VARCHAR(6) NOT NULL,
    SoLuong SMALLINT NOT NULL CHECK(SoLuong >0)
    CONSTRAINT PK_BanHang PRIMARY KEY(MaSP, MaNV),
    FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
GO 

INSERT LoaiSP VALUES
('L001', N'Bánh kẹo'),
('L002', N'Nước ngọt'),
('L003', N'Gia dụng'),
('L004', N'Văn phòng phẩm'),
('L005', N'Đồ chơi trẻ em')

 

INSERT SanPham VALUES 
('SP001', N'Bánh đậu xanh', 'L001', 200000),
('SP002', N'Bánh xốp', 'L001', 50000),
('SP003', N'Coca', 'L002', 200000),
('SP004', N'Bút bi', 'L004', 10000),
('SP005', N'Nồi', 'L001', 100000)
GO

INSERT BanHang(MaNV, MaSP, SoLuong) VALUES
('NV01', 'SP001', 3),
('NV01', 'SP002', 2),
('NV03', 'SP005', 6),
('NV02', 'SP003', 8),
('NV03', 'SP002', 9),
('NV04', 'SP004', 10)


--Câu 1
INSERT NhanVien VALUES 
('NV01', N'Nguyễn Chí Phèo', 0, N'Quảng Trị', 18),
('NV02', N'Nguyễn Thị Nở', 1, N'Nam Định', 25),
('NV03', N'Huỳnh Thanh Khởi', 0, N'Quảng Nam', 31),
('NV04', N'Nguyễn Ngọc Hiển', 0, N'Bình Định', 26),
('NV05', N'Nguyễn Văn Đông',0, N'Kon Tum', 20)


INSERT NhanVien VALUES ('NV05', N'Nguyễn Văn Đông',0, N'Kon Tum', 20)

GO 

-- Xáo nhân viên ở kon tum
DELETE FROM NhanVien WHERE QueQuan = N'Kon Tum'


-- câu 3 tang gia tri san pham thuoc loai L001
UPDATE SanPham SET GiaBan = GiaBan*2 WHERE MaLoaiSP = 'L001'


-- câu 4 Liet ke toan bo thong tin nhan vien trong cty
SELECT * FROM NhanVien

-- Câu 5 liệt kê nhân viên 23 tuổi ở bình đinh
SELECT * FROM NhanVien WHERE Tuoi >= 23 AND QueQuan = N'Bình Định'

-- câu 6 liệt kê mã sản phẩm của sản phẩm đã được bán
SELECT MaSP FROM SanPham WHERE TenSP IN (
SELECT A.TenSP 
FROM SanPham A INNER JOIN BanHang B
ON A.MaSP = B.MaSP 
)

-- Câu 7 Liệt kê Nhân viên có họ Nguyễn
SELECT * FROM NhanVien WHERE HoTenNV LIKE N'Nguyễn%'

--Câu 8 Liệt kê nhân viên tên hoa
SELECT * FROM NhanVien WHERE HoTenNV LIKE N'%Hoa'

--Cau 9 Liệt kê sản phẩm tên bao gồm 12 ký tự
SELECT * FROM SanPham WHERE LEN(TenSP) = 12

--cau 10 Liệt kê sản phẩm thuộc loại mỹ phẩm
SELECT * FROM SanPham A INNER JOIN LoaiSP B ON A.MaLoaiSP = B.MaLoaiSP
WHERE B.TenLoaiSP=N'Mỹ Phẩm'



-- câu 11  Liệt kê sản phẩm giá bản < 20000 hoặc chưa từng được bán lần nào

SELECT * FROM SanPham WHERE GiaBan <20000 OR TenSP NOT IN (
SELECT A.TenSP FROM SanPham A INNER JOIN BanHang B ON A.MaSP = B.MaSP
)

-- Câu 12 Liệt kê những nhân viên chưa bán được sản phẩm nào và những nhân viên chỉ bản được sản phẩm bột giặt
SELECT A.MaNV,A.HoTenNV,A.GioiTinh,A.QueQuan,A.Tuoi FROM NhanVien A 
INNER JOIN BanHang B ON A.MaNV = B.MaNV
INNER JOIN SanPham S ON S.MaSP =B.MaSP
WHERE S.TenSP=N'Bột giặt'
UNION ALL
SELECT * FROM NhanVien WHERE MaNV NOT IN (
SELECT A.MaNV FROM NhanVien A INNER JOIN BanHang B ON A.MaNV = B.MaNV
)





-- Câu 13 Liet ke nhung nhan vien que o Gia Lai va chua tung ban sp nao
SELECT * FROM NhanVien WHERE MaNV NOT IN (
SELECT A.MaNV 
FROM NhanVien A INNER JOIN BanHang B 
ON B.MaNV = A.MaNV INNER JOIN SanPham S
ON S.MaSP = B.MaSP
) AND QueQuan = N'Gia Lai'

--Câu 14 Hãy liệt kê MaSP, TênSP, Mã Loại SP, Giá Bán, Tên Loại SP của tất cả những sản phẩm đã có niêm yết giá bán
SELECT S.MaSP, S.TenSP, S.MaLoaiSP, S.GiaBan, L.TenLoaiSP 
FROM SanPham S 
INNER JOIN LoaiSP L ON S.MaLoaiSP = L.MaLoaiSP 
WHERE S.GiaBan IS NOT  NULL


/* Câu 15 Hãy liệt kê MãNV, Họ tên NV, Giới Tính, Quê Quán của nhân viên và mã sản phẩm, tên sản phẩm, 
--loại sản phẩm, tên loại sản phẩm, 
-- số lượng đã bán của tất cả các những nhân viên đã từng bán được hàng.
*/
SELECT A.MaNV, A.HoTenNV, A.GioiTinh, A.QueQuan, S.MaSP, S.TenSP, L.MaLoaiSP, L.TenLoaiSP, B.SoLuong 
FROM NhanVien A 
INNER JOIN BanHang B
ON A.MaNV = B.MaNV 
INNER JOIN SanPham S 
ON S.MaSP = B.MaSP 
INNER JOIN LoaiSP L 
ON L.MaLoaiSP =S.MaLoaiSP

-- Câu  16 Hãy liệt kê Mã Loại SP, Tên loại SP của những loại sản phẩm đã từng được bán 

SELECT L.TenLoaiSP, L.MaLoaiSP 
FROM LoaiSP L 
WHERE L.MaLoaiSP IN (
SELECT S.MaLoaiSP 
FROM SanPham S 
INNER JOIN BanHang B 
ON S.MaSP = B.MaSP 
GROUP BY S.MaLoaiSP
)

-- Câu 17 Liệt kê tên của nhân viên, nếu trùng thì hiển thị 1 lần
SELECT DISTINCT HoTenNV FROM NhanVien

--cau 18 Hãy liệt kê MaNV, TênNV, Quê Quán của tất cả nhân viên, nếu bạn nào chưa có quê quán thì mục quê quán sẽ hiển thị là 'Cõi trên xuống'

SELECT MaNV, HoTenNV, ISNULL(QueQuan, N'Cõi trên xuống') AS QueQuan FROM NhanVien 

-- câu 19 Hãy liệt kê 5 nhân viên có tuổi đời cao nhất trong công ty
SELECT TOP 5 *
FROM NhanVien 
ORDER BY Tuoi DESC

--câu 20 Hãy liệt kê những nhân viên có tuổi đời từ 25 đến 35 tuổi
SELECT * FROM NhanVien WHERE Tuoi BETWEEN 25 AND 35