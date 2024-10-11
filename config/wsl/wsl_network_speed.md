# "Fixing" netwoks for WSL2

## Getting Started

- Go to you `$HOME`, change `.wslconfig`.
  ```.wslconfig
  [wsl2]
  memory=8GB
  processors=4
  localhostforwarding=true
  
  # Some say this helps, but never worked for me
  # Remove comments below if you wanna try
  # Beware that sometimes `networkingMode=mirrored` will cause problems with docker engine
  #[experimental]
  #networkingMode=mirrored
  #dnsTunneling=true
  #firewall=true
  ```

## Disabling Large Send Offload

- List networks that have `WSL` in the `Name`:
  ```powershell
  Get-NetAdapter -Name "*WSL*" -IncludeHidden | Select-Object Name
  ```

  - In W11, they will look like this:
    ```txt
    vEthernet (WSL (Hyper-V firewall))
    ```

  - W10
    ```txt
    vEthernet (WSL)
    ```

- Verify the WSL network attributes using the following command, change `<NETWORK>` to the network name you got before:
  ```powershell
  Get-NetAdapterAdvancedProperty -IncludeHidden -Name "<NETWORK>" | Format-Table -AutoSize
  ```

- If `Large Send Offload Version 2 (IPv4)` and `Large Send Offload Version 2 (IPv6)` are set to `Enabled`, disable them using the following commands:
  ```powershell
  Set-NetAdapterAdvancedProperty -IncludeHidden -Name "<NETWORK>" -DisplayName "Large Send Offload Version 2 (IPv4)" -DisplayValue Disabled
  Set-NetAdapterAdvancedProperty -IncludeHidden -Name "<NETWORK>" -DisplayName "Large Send Offload Version 2 (IPv6)" -DisplayValue Disabled
  ```

## Enabling forwarding 

- To get your physical networks you can use:
  ```powershell
  Get-NetAdapter -IncludeHidden -Physical | Select-Object Name
  ```

- Run the command below to enable forwarding to ipv4 interface on the selected network, will only work on physical interfaces.
  - Change `<NETWORK>` to the desired network.
  ```powershell
  netsh int ipv4 set interface "<NETWORK>" forwarding=enable
  netsh int ipv6 set interface "<NETWORK>" forwarding=enable
  ```

## Changing network settings for WSL

- Run this commands to set a new resolv.conf and disable auto configs from WSL.
  ```shell
  sudo rm /etc/resolv.conf
  sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
  sudo bash -c 'echo "[network]" > /etc/wsl.conf'
  sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
  ```

- Run the command below to avoid wsl changing back the wsl.conf, this will put the resolv.conf on read only.
  ```shell
  sudo chattr +i /etc/resolv.conf
  ```

## Turn off TCP offload in WSL

- This will install a tool in WSL `ethtool`, you can use it to disable segmentation offload for TCP inside WSL.
  ```
  sudo apt install ethtool
  sudo ethtool -K eth0 tso off
  sudo ethtool -k eth0 | grep 'tcp-segmentation-offload'
  ```

## Release IPs/DNS

- This will flush your network, it will require a restart.
  ```powershell
  netsh winsock reset 
  netsh int ip reset all
  netsh winhttp reset proxy
  ipconfig /flushdns
  ```

## If nothing works, try to reset windows networks

- Look for `Network troubleshooting on your device` on [Fix Connection Issues in Windows](https://support.microsoft.com/en-us/windows/fix-wi-fi-connection-issues-in-windows-9424a1f7-6a3b-65a6-4d78-7f07eee84d2c#WindowsVersion=Windows_11)
