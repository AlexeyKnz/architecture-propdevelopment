# RBAC Роли для Kubernetes в PropDevelopment

## Таблица ролей и полномочий

| Роль | Описание прав | Группы пользователей | API Resources | Verbs |
|------|--------------|----------------------|--------------|-------|
| **cluster-admin** | Полный доступ ко всем ресурсам кластера | DevOps, Архитекторы | `*` | `*` |
| **namespace-admin** | Полный доступ в назначенных namespace | Владельцы продуктов | `*` (в namespace) | `create`, `delete`, `update`, `get`, `list`, `watch` |
| **security-auditor** | Чтение секретов и конфигураций | ИБ, Аудиторы | `secrets`, `configmaps` | `get`, `list`, `watch` |
| **developer** | Управление workloads | Разработчики | `deployments`, `pods`, `services` | `*` |
| **viewer** | Только просмотр (кроме секретов) | Менеджеры, Операционные команды | `*` (кроме `secrets`) | `get`, `list`, `watch` |

## Дополнительные параметры

| Параметр | cluster-admin | namespace-admin | security-auditor | developer | viewer |
|----------|--------------|----------------|-----------------|-----------|-------|
| **Scope** | Cluster-wide | Namespaced | Cluster-wide | Namespaced | Cluster-wide |
| **Пример binding** | ClusterRoleBinding | RoleBinding | ClusterRoleBinding | RoleBinding | ClusterRoleBinding |
| **Доступ к secrets** | Полный | Полный (в ns) | Только чтение | Нет | Нет |
| **Может создавать pods** | Да | Да | Нет | Да | Нет |

> **Примечания**:
> 1. Для namespace-admin и developer рекомендуется создавать отдельные RoleBinding для каждого namespace
> 2. security-auditor получает доступ только к чтению критичных ресурсов на уровне всего кластера
> 3. viewer не может просматривать secrets даже в режиме readonly