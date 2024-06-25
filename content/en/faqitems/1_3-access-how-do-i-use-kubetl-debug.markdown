+++
question = "How do I use `kubectl debug node` with Bottlerocket?"
group = "Access"
+++

The [debug node](https://kubernetes.io/docs/tasks/debug/debug-cluster/kubectl-node-debug/) option from `kubectl` can be used to gain access to a Bottlerocket node as follows:

```console
kubectl debug node/<node name> -it --image=ubuntu --profile=sysadmin
```

This is a useful alternative to SSH or SSM. Use a `kubectl` version of 1.30 or later to ensure that the `sysadmin` profile is available. Once the debug pod is started and you have a shell, you can run `chroot /host apiclient exec admin bash` to access the admin container (if enabled) or `chroot /host <command>` to run commands from the Bottlerocket OS.

The Pod created is privileged so ensure it is removed after use.
