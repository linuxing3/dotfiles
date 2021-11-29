  ;; NOTE: This file is generated from ~/.dotfiles/System.org.  Please see commentary there.

  (define-module (acidburn)
    #:use-module (base-system)
    #:use-module (gnu)
    #:use-module (nongnu packages linux))

  (operating-system
   (inherit base-operating-system)
   (host-name "acidburn")

   (firmware (list linux-firmware sof-firmware))

   (mapped-devices
    (list (mapped-device
           (source (uuid "15ece913-c423-49aa-ac42-3bad39fdd966"))
           (target "system-root")
           (type luks-device-mapping))))

   (file-systems (cons*
                  (file-system
                   (device (file-system-label "system-root"))
                   (mount-point "/")
                   (type "ext4")
                   (dependencies mapped-devices))
                  (file-system
                   (device "/dev/nvme0n1p1")
                   (mount-point "/boot/efi")
                   (type "vfat"))
                  %base-file-systems)))
