+++
question = "How do I collect NVIDIA GPU diagnostics on Bottlerocket?"
group = "Troubleshooting"
+++

The admin container includes a patched version of NVIDIA's `nvidia-bug-report.sh` that works on Bottlerocket.
You must be running a GPU-enabled variant (e.g. `aws-k8s-*-nvidia` or `aws-ecs-*-nvidia`).

Enter the admin container and run the script:

```bash
sudo nvidia-bug-report.sh
```

The script automatically detects Bottlerocket, installs needed tools, and collects GPU diagnostics.
The output is saved as `nvidia-bug-report.log.gz` in the current directory.
