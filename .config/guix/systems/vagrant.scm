;; NOTE: This file is generated from ~/.dotfiles/System.org.  Please see commentary there.

(define-module (vagrant)
  #:use-module (base-system)
  #:use-module (gnu))

(operating-system
 (inherit base-operating-system)
 (host-name "vagrant.local")

 (mapped-devices
  (list (mapped-device
         (source (uuid "eaba53d9-d7e5-4129-82c8-df28bfe6527e"))
         (target "system-root")
         (type luks-device-mapping))))

 (file-systems (cons*
                (file-system
                 (device (file-system-label "system-root"))
                 (mount-point "/")
                 (type "ext4")
                 (dependencies mapped-devices))
                %base-file-systems)))
