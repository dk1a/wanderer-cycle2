export function formatEntity(entity: string): string {
  if (entity.length <= 10) {
    return entity;
  }
  const start = entity.slice(0, 5);
  const end = entity.slice(-5);
  return `${start}...${end}`;
}
