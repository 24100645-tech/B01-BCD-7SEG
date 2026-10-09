# B01 — BCD to 7-Segment Decoder

## 1. Mục đích

Thiết kế mạch tổ hợp giải mã đầu vào BCD 4 bit thành tín hiệu điều khiển LED 7 đoạn loại common-anode.

Bảng chân lý được xây dựng từ đặc tả B01 trước khi triển khai RTL, làm cơ sở cho thiết kế và kiểm tra chức năng của mạch.

## 2. Giao diện

| Tín hiệu      | Hướng  | Độ rộng | Ý nghĩa                 |
| ------------- | ------ | ------: | ----------------------- |
| `ui_in[3:0]`  | Input  |   4 bit | Mã BCD đầu vào          |
| `uo_out[6:0]` | Output |   7 bit | Điều khiển các đoạn LED |
| `uo_out[7]`   | Output |   1 bit | Cờ báo mã không hợp lệ  |

Quy ước thứ tự đầu ra:

`uo_out[7:0] = {invalid, a, b, c, d, e, f, g}`

Trong đó:

* `uo_out[7] = invalid`
* `uo_out[6] = a`
* `uo_out[5] = b`
* `uo_out[4] = c`
* `uo_out[3] = d`
* `uo_out[2] = e`
* `uo_out[1] = f`
* `uo_out[0] = g`

## 3. Quy ước hoạt động

* LED 7 đoạn loại common-anode, đầu ra active-low.
* `0`: đoạn LED sáng.
* `1`: đoạn LED tắt.
* Đầu vào từ `0000` đến `1001` tương ứng các chữ số thập phân từ 0 đến 9.
* Đầu vào từ `1010` đến `1111` là mã BCD không hợp lệ.
* Với mã không hợp lệ, cả 7 đoạn LED đều tắt và `invalid = 1`.
* Với mã hợp lệ, `invalid = 0`.

## 4. Bảng chân lý

Trong bảng dưới đây, thứ tự các bit đầu ra là `invalid | a b c d e f g`.

| A B C D | Đầu vào |       Chữ số | invalid | a b c d e f g |
| ------- | ------- | -----------: | ------: | ------------- |
| 0 0 0 0 | 0000    |            0 |       0 | 0 0 0 0 0 0 1 |
| 0 0 0 1 | 0001    |            1 |       0 | 0 1 1 0 0 0 0 |
| 0 0 1 0 | 0010    |            2 |       0 | 1 1 0 1 1 0 1 |
| 0 0 1 1 | 0011    |            3 |       0 | 1 1 1 1 0 0 1 |
| 0 1 0 0 | 0100    |            4 |       0 | 0 1 1 0 0 1 1 |
| 0 1 0 1 | 0101    |            5 |       0 | 1 0 1 1 0 1 1 |
| 0 1 1 0 | 0110    |            6 |       0 | 1 0 1 1 1 1 1 |
| 0 1 1 1 | 0111    |            7 |       0 | 1 1 1 0 0 0 0 |
| 1 0 0 0 | 1000    |            8 |       0 | 1 1 1 1 1 1 1 |
| 1 0 0 1 | 1001    |            9 |       0 | 1 1 1 1 0 1 1 |
| 1 0 1 0 | 1010    | Không hợp lệ |       1 | 1 1 1 1 1 1 1 |
| 1 0 1 1 | 1011    | Không hợp lệ |       1 | 1 1 1 1 1 1 1 |
| 1 1 0 0 | 1100    | Không hợp lệ |       1 | 1 1 1 1 1 1 1 |
| 1 1 0 1 | 1101    | Không hợp lệ |       1 | 1 1 1 1 1 1 1 |
| 1 1 1 0 | 1110    | Không hợp lệ |       1 | 1 1 1 1 1 1 1 |
| 1 1 1 1 | 1111    | Không hợp lệ |       1 | 1 1 1 1 1 1 1 |

## 5. Phương pháp xây dựng

Bảng chân lý được lập dựa trên các yêu cầu sau:

1. Xác định 4 bit đầu vào và 8 bit đầu ra.
2. Liệt kê đầy đủ 16 tổ hợp đầu vào từ `0000` đến `1111`.
3. Xác định các đoạn cần sáng cho từng chữ số từ 0 đến 9.
4. Chuyển trạng thái sáng/tắt thành mức logic theo quy ước active-low.
5. Đặt `invalid = 1` và tắt toàn bộ các đoạn LED với đầu vào từ 10 đến 15.

Bảng chân lý này sẽ được sử dụng làm cơ sở độc lập để triển khai RTL và xây dựng testbench kiểm tra chức năng.

## 6. Kiểm tra tính nhất quán

* Có đủ 16 tổ hợp đầu vào.
* Các mã từ 0 đến 9 có `invalid = 0`.
* Các mã từ 10 đến 15 có `invalid = 1`.
* Đầu ra tuân theo thứ tự `{invalid, a, b, c, d, e, f, g}`.
* Đầu ra các đoạn LED tuân theo quy ước active-low.
