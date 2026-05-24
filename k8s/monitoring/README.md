# Monitoring with Prometheus and Grafana

This directory contains monitoring setup for the Kubernetes cluster using Prometheus and Grafana.

## Components

### Prometheus
- Metrics collection and storage
- Time-series database
- PromQL query language
- 7-day retention period

### Grafana
- Visualization dashboards
- Pre-configured with Prometheus datasource
- Default credentials: admin/admin

### Node Exporter
- Hardware and OS metrics
- CPU, memory, disk, network stats

### Kube State Metrics
- Kubernetes object metrics
- Pods, deployments, services status

## Installation

### Using Helm

```bash
# Add Prometheus Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Create monitoring namespace
kubectl create namespace monitoring

# Install Prometheus stack
helm install prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f k8s/monitoring/prometheus-values.yaml
```

### Verify Installation

```bash
# Check pods
kubectl get pods -n monitoring

# Check services
kubectl get svc -n monitoring
```

## Access Dashboards

### Grafana

```bash
# Port forward to access Grafana
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80

# Or use minikube service
minikube service prometheus-grafana -n monitoring
```

Then open: http://localhost:3000
- Username: `admin`
- Password: `admin`

### Prometheus

```bash
# Port forward to access Prometheus
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090
```

Then open: http://localhost:9090

## Pre-installed Dashboards

Grafana comes with many pre-installed dashboards:

1. **Kubernetes / Compute Resources / Cluster**
   - Overall cluster resource usage
   - CPU, memory, network

2. **Kubernetes / Compute Resources / Namespace (Pods)**
   - Per-namespace resource usage
   - Pod metrics

3. **Kubernetes / Compute Resources / Pod**
   - Individual pod metrics
   - Container resource usage

4. **Node Exporter / Nodes**
   - Node-level metrics
   - System stats

## Custom Queries

### PromQL Examples

**CPU Usage by Pod:**
```promql
rate(container_cpu_usage_seconds_total{namespace="default"}[5m])
```

**Memory Usage by Pod:**
```promql
container_memory_usage_bytes{namespace="default"}
```

**HTTP Request Rate:**
```promql
rate(http_requests_total[5m])
```

**Pod Restart Count:**
```promql
kube_pod_container_status_restarts_total{namespace="default"}
```

## Monitoring Our Todo App

### Key Metrics to Watch

1. **Pod Health**
   - Pod status and restarts
   - Container resource usage

2. **Database Performance**
   - PostgreSQL connections
   - Query performance

3. **API Performance**
   - Request rate
   - Response time
   - Error rate

4. **Resource Usage**
   - CPU utilization
   - Memory consumption
   - Network I/O

## Alerting (Optional)

To enable alerting, update `prometheus-values.yaml`:

```yaml
alertmanager:
  enabled: true
  config:
    global:
      resolve_timeout: 5m
    route:
      receiver: 'null'
    receivers:
    - name: 'null'
```

## Cleanup

```bash
# Uninstall Prometheus stack
helm uninstall prometheus -n monitoring

# Delete namespace
kubectl delete namespace monitoring
```

## What This Demonstrates

- Monitoring infrastructure setup
- Prometheus metrics collection
- Grafana visualization
- Kubernetes observability
- Production-ready monitoring stack
- DevOps best practices

## Resources

- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
- [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
- [PromQL Basics](https://prometheus.io/docs/prometheus/latest/querying/basics/)

---

**Monitor everything!** 📊
