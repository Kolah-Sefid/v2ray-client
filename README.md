# 🛡️ v2ray Client - کلاه سفید

کلاینت حرفه‌ای v2ray برای ویندوز با پشتیبانی از **Xray-core**، طراحی‌شده برای کاربران غیرفنی.

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Architecture](https://img.shields.io/badge/arch-64--bit%20%7C%2032--bit-green)
![License](https://img.shields.io/badge/license-MIT-orange)
![Website](https://img.shields.io/badge/website-kolah--sefid.ir-purple)

---

## 📥 دانلود

**نصب‌کننده‌ی حرفه‌ای:**

🔗 **[https://dl.nextup1.ir/soft/v2ray-Setup.exe](https://dl.nextup1.ir/soft/v2ray-Setup.exe)**

> فقط دانلود کنید، دابل‌کلیک کنید و نصب کنید. تمام.

---

## ✨ ویژگی‌ها

- ✅ **پشتیبانی هیبرید** از ویندوز ۶۴ و ۳۲ بیتی
- ✅ **اتصال/قطع با یک دابل‌کلیک** — بدون نیاز به دانش فنی
- ✅ **رابط کاربری ساده** برای وارد کردن لینک
- ✅ **پشتیبانی از پروتکل‌های مدرن**: `VLESS`, `VMess`, `Trojan`, `REALITY`, `TLS`
- ✅ **نمایش وضعیت لحظه‌ای** اتصال در پنجره‌ی Monitor
- ✅ **نمایش لاگ زنده‌ی Xray** در پنجره‌ی Connect
- ✅ **غیرفعال‌سازی خودکار پروکسی** در صورت قطع شدن Xray
- ✅ **Exception خودکار** برای Windows Defender
- ✅ **Shortcut خودکار** روی دسکتاپ با آیکون‌های اختصاصی
- ✅ **نصب‌کننده‌ی حرفه‌ای** با Uninstaller
- ✅ **بدون نیاز به v2rayN** یا هیچ برنامه‌ی گرافیکی اضافه

---

## 📦 نصب

1. فایل **[v2ray-Setup.exe](https://dl.nextup1.ir/soft/v2ray-Setup.exe)** را دانلود کنید
2. روی فایل **دابل‌کلیک** کنید
3. **UAC** می‌آید → **Yes** را بزنید
4. صبر کنید تا نصب کامل شود
5. سه Shortcut روی دسکتاپ ساخته می‌شود:
   - 🟢 **Connect v2ray**
   - 🔴 **Disconnect v2ray**
   - ⚙️ **Config v2ray**

---

## 🎯 استفاده

### 📝 قدم ۱: تنظیم لینک اتصال

1. روی Shortcut **`Config v2ray`** روی دسکتاپ دابل‌کلیک کنید
2. پنجره‌ی تنظیمات باز می‌شود
3. لینک `vless://` خود را در کادر **پیست** کنید
4. روی دکمه‌ی **Save** کلیک کنید
5. پیام **`Link saved successfully!`** نمایش داده می‌شود
6. پنجره را ببندید

```
⚠️ فقط یک لینک! نه چند تا.
```

### 🟢 قدم ۲: اتصال

روی Shortcut **`Connect v2ray`** روی دسکتاپ دابل‌کلیک کنید.

دو پنجره باز می‌شود:
- **`v2ray - Connecting`** → لاگ زنده‌ی Xray
- **`v2ray - Monitor`** → وضعیت لحظه‌ای اتصال

### 🔴 قدم ۳: قطع اتصال

روی Shortcut **`Disconnect v2ray`** روی دسکتاپ دابل‌کلیک کنید.

تمام پنجره‌ها بسته می‌شوند و پروکسی غیرفعال می‌شود.

### 🔄 اگر کانفیگ کار نکرد

1. یک لینک `vless://` جدید از سرویس‌دهنده بگیرید
2. روی **`Config v2ray`** دابل‌کلیک کنید
3. لینک قبلی را پاک کنید
4. لینک جدید را پیست کنید
5. روی **Save** کلیک کنید
6. دوباره **Connect v2ray** را بزنید

---

## 📁 محل ذخیره‌ی کانفیگ

فایل کانفیگ در این مسیر ذخیره می‌شود:

```
C:\Users\YourName\AppData\Roaming\v2ray Client\config.txt
```

> نیازی نیست دستی به این مسیر بروید. فقط از Shortcut **Config v2ray** استفاده کنید.

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
│   ├── watchdog.ps1            ← غیرفعال‌سازی خودکار
│   ├── config-editor.ps1       ← رابط کاربری
│   └── config-editor.bat       ← اجراگر
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

**Powered by Kolah Sefid** 🛡️

[![Website](https://img.shields.io/badge/Website-kolah--sefid.ir-blue)](https://kolah-sefid.ir)
[![GitHub](https://img.shields.io/badge/GitHub-Kolah--Sefid-black?logo=github)](https://github.com/Kolah-Sefid)

</div>
