---
- name: Bootstrap jumpbox
  hosts: jumpbox
  become: true
      
  tasks:
    - name: Install prerequisites
      apt:
        name:
          - ca-certificates
          - curl
          - gnupg
          - kubectl
        state: present
        update_cache: yes

    - name: Download Tailscale signing key
      ansible.builtin.get_url:
        url: "{{ tailscale_key_url }}"
        dest: "/usr/share/keyrings/tailscale-archive-keyring.gpg"
        mode: '0644'
      become: true

    - name: Add Tailscale apt repository
      ansible.builtin.apt_repository:
        repo: "deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu {{ ubuntu_version }} main"
        state: present
      notify: Update apt cache

    - name: Install Tailscale
      apt:
        name:
          - tailscale
        state: present
      notify: Pass reminder

  handlers:
    - name: Update apt cache
      ansible.builtin.apt:
        update_cache: yes

    - name: Pass reminder
      debug:
        msg: "Done! Run 'sudo tailscale up' to finish setup!"
