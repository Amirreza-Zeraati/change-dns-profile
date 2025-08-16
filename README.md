# 🖥️ PowerShell DNS Switcher

A simple PowerShell profile script that makes changing DNS servers quick and easy.
It allows you to:

* 🔄 Switch between predefined DNS profiles
* ♻️ Reset DNS to default settings
* 👀 Check which DNS profile is currently active

---

## 🚀 Features

* Predefined DNS profiles (`electro`, `shecan`, `shelter`, `radar`)
* `set-dns` → Switch to a DNS profile
* `reset-dns` → Restore system default DNS
* `show-dns` → Detect which profile (if any) is currently active

---

## ⚡ Installation

1. Open your **PowerShell profile** (create one if it doesn’t exist):

   ```powershell
   notepad $PROFILE
   ```

2. Copy the script from this repository into your profile.

3. Restart PowerShell to apply changes.

---

## 📘 Usage

### ✅ Set a DNS profile

```powershell
set-dns shecan
```

Output:

```
Done
```

### 🔄 Reset DNS

```powershell
reset-dns
```

Output:

```
DNS settings reset
```

### 👀 Show active DNS

```powershell
show-dns
```

Output (example):

```
--: shecan
```

If no match is found:

```
Current DNS settings do not match any predefined profile.
```

---

## 🛠️ DNS Profiles

You can customize the DNS servers inside the `$dnsProfiles` hashtable:

```powershell
$dnsProfiles = @{
    "electro" = @("78.157.42.101", "78.157.42.100")
    "shecan"  = @("178.22.122.100", "185.51.200.2")
    "shelter" = @("94.103.125.157", "94.103.125.158")
    "radar"   = @("10.202.10.11", "10.202.10.10")
}
```
