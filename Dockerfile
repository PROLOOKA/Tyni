FROM tinycorelinux/tinycore:latest

# تثبيت SSH وأدوات أساسية
RUN tce-load -wi openssh.tcz || true

# إنشاء مجلدات SSH
RUN sudo mkdir -p /var/run/sshd

# توليد مفاتيح SSH
RUN ssh-keygen -A

# تعيين كلمة مرور root
RUN echo "root:lookmora" | chpasswd

# تفعيل تسجيل الدخول عبر SSH
RUN sudo sed -i 's/#PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config || true && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/local/etc/init.d/openssh", "start"]
