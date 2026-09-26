# 🚀 v2ray Client

کلاینت حرفه‌ای v2ray برای ویندوز با پشتیبانی از **Xray-core**، طراحی‌شده برای کاربران غیرفنی.

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Architecture](https://img.shields.io/badge/arch-64--bit%20%7C%2032--bit-green)
![License](https://img.shields.io/badge/license-MIT-orange)

---

## 📥 دانلود سریع

**پکیج کامل آماده (شامل Xray-core):**

🔗 **[https://dl.nextup1.ir/soft/v2ray.zip](https://dl.nextup1.ir/soft/v2ray.zip)**

> این پکیج شامل تمام فایل‌های لازم است. کافیه Extract کنید و `setup.bat` را اجرا کنید.

---

## ✨ ویژگی‌ها

- ✅ **پشتیبانی هیبرید** از ویندوز ۶۴ و ۳۲ بیتی
- ✅ **اتصال/قطع با یک دابل‌کلیک** — بدون نیاز به دانش فنی
- ✅ **پشتیبانی از پروتکل‌های مدرن**: `VLESS`, `VMess`, `Trojan`, `REALITY`, `TLS`
- ✅ **نمایش وضعیت لحظه‌ای** اتصال در پنجره‌ی Monitor
- ✅ **نمایش لاگ زنده‌ی Xray** در پنجره‌ی Connect
- ✅ **غیرفعال‌سازی خودکار پروکسی** در صورت قطع شدن Xray
- ✅ **Exception خودکار** برای Windows Defender
- ✅ **Shortcut خودکار** روی دسکتاپ با آیکون سبز و قرمز
- ✅ **بدون نیاز به v2rayN** یا هیچ برنامه‌ی گرافیکی اضافه

---

## 📦 نصب

### روش ۱: دانلود پکیج کامل (توصیه‌شده)

1. فایل **[v2ray.zip](https://dl.nextup1.ir/soft/v2ray.zip)** را دانلود کنید
2. فایل ZIP را **Extract** کنید
3. روی **`setup.bat`** راست‌کلیک کنید → **Run as Administrator**
4. فایل **`config.txt`** را باز کنید و لینک `vless://` خود را داخل آن پیست کنید
5. روی **`Connect v2ray`** روی دسکتاپ دابل‌کلیک کنید

### روش ۲: دانلود دستی Xray-core

#### قدم ۱: دانلود Xray-core

این پروژه نیاز به **Xray-core** دارد. از لینک زیر دانلود کنید:

🔗 https://github.com/XTLS/Xray-core/releases

| ویندوز | فایل |
|---|---|
| ویندوز ۶۴ بیتی | `Xray-windows-64.zip` |
| ویندوز ۳۲ بیتی | `Xray-windows-32.zip` |

#### قدم ۲: کپی فایل‌ها

بعد از **Extract** کردن فایل ZIP:

**برای ویندوز ۶۴ بیتی:**
فایل‌های `xray.exe`, `wintun.dll`, `geoip.dat`, `geosite.dat` را از `Xray-windows-64.zip` به پوشه‌ی **`core-64/`** کپی کنید.

**برای ویندوز ۳۲ بیتی:**
فایل‌های `xray.exe`, `wintun.dll`, `geoip.dat`, `geosite.dat` را از `Xray-windows-32.zip` به پوشه‌ی **`core-32/`** کپی کنید.

#### قدم ۳: نصب اولیه

1. روی فایل **`setup.bat`** راست‌کلیک کنید
2. گزینه‌ی **Run as Administrator** را انتخاب کنید
3. صبر کنید تا پیام موفقیت نمایش داده شود

#### قدم ۴: تنظیم لینک اتصال

1. فایل **`config.txt`** را باز کنید (با Notepad)
2. **متن داخل فایل را کامل پاک کنید**
3. فقط **یک لینک** `vless://` را به جای آن پیست کنید
4. فایل را ذخیره کنید (`Ctrl + S`)

#### قدم ۵: اتصال

روی **`Connect v2ray`** روی دسکتاپ دابل‌کلیک کنید.

---

## 🎯 استفاده

### 🟢 برای اتصال

روی **`Connect v2ray`** روی دسکتاپ دابل‌کلیک کنید.

دو پنجره باز می‌شود:
- **`v2ray - Connecting`** → لاگ زنده‌ی Xray
- **`v2ray - Monitor`** → وضعیت لحظه‌ای اتصال

### 🔴 برای قطع اتصال

روی **`Disconnect v2ray`** روی دسکتاپ دابل‌کلیک کنید.

تمام پنجره‌ها بسته می‌شوند و پروکسی غیرفعال می‌شود.

### 🔄 اگر کانفیگ کار نکرد

1. یک لینک `vless://` جدید از سرویس‌دهنده بگیرید
2. فایل `config.txt` را باز کنید
3. لینک قبلی را پاک کنید
4. لینک جدید را پیست کنید
5. ذخیره کنید
6. دوباره **Connect v2ray** را بزنید

---

## 📁 ساختار پروژه

```
v2ray-client/
│
├── core-64/                    ← فایل‌های Xray (64-bit)
├── core-32/                    ← فایل‌های Xray (32-bit)
├── config/
│   └── make_config.ps1         ← تبدیل vless:// به JSON
├── scripts/
│   ├── connect.bat             ← اتصال
│   ├── disconnect.bat          ← قطع
│   ├── monitor.bat             ← نمایش وضعیت
│   └── watchdog.ps1            ← غیرفعال‌سازی خودکار
│
├── config.txt                  ← لینک vless://
├── setup.bat                   ← نصب اولیه
├── README.md                   ← همین فایل
└── README.html                 ← راهنمای شیک
```

---

## ⚠️ نکات مهم

- 🚫 این پوشه را در مسیر با **حروف فارسی** قرار ندهید
- 🚫 پوشه‌های `core-64`، `core-32`، `config` و `scripts` را **حذف یا جابه‌جا نکنید**
- 🛡️ اگر آنتی‌ویروس غیر از **Windows Defender** دارید، این پوشه را در **لیست سفید** آن اضافه کنید
- 🌐 پس از اتصال، همه‌ی مرورگرها از پروکسی استفاده می‌کنند
- 🔌 برای قطع، حتماً از **Disconnect v2ray** استفاده کنید
- 📝 فایل `config.txt` باید همیشه فقط **یک لینک** داشته باشد

---

## 🛡️ آنتی‌ویروس

فایل `xray.exe` ممکن است توسط بعضی آنتی‌ویروس‌ها به عنوان **تهدید** شناسایی شود (False Positive). این یک مشکل شناخته‌شده است.

**راه‌حل:** فایل `setup.bat` به‌طور خودکار پوشه را به **Windows Defender** اضافه می‌کند. برای آنتی‌ویروس‌های دیگر، **دستی** پوشه را در لیست سفید اضافه کنید.

---

## 🌐 وب‌سایت

- **وب‌سایت:** [kolah-sefid.ir](https://kolah-sefid.ir)
- **گیت‌هاب:** [Kolah-Sefid](https://github.com/Kolah-Sefid)

---

## 📞 پشتیبانی

- **وب‌سایت:** [kolah-sefid.ir](https://kolah-sefid.ir)

---

## 📄 مجوز

این پروژه تحت مجوز **MIT** منتشر شده است.

---

<div align="center">

**Powered by Kolah Sefid**

[![Website](https://img.shields.io/badge/Website-kolah--sefid.ir-blue)](https://kolah-sefid.ir)
[![GitHub](https://img.shields.io/badge/GitHub-Kolah--Sefid-black?logo=github)](https://github.com/Kolah-Sefid)

</div>
