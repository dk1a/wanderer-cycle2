import { useEntityQuery } from "@latticexyz/react";
import { getComponentValueStrict, Has } from "@latticexyz/recs";
import { useState } from "react";
import { useMUD } from "../../MUDContext";
import { formatEntity } from "../../mud/utils/sliceAddress";

const AdminPanel = () => {
  const { components } = useMUD();
  const { AffixPrototype } = components;
  const affixPrototypeEntities = useEntityQuery([Has(AffixPrototype)]);
  const [sortConfig, setSortConfig] = useState<{
    key: string;
    direction: "asc" | "desc";
  } | null>(null);

  const handleSort = (key: string) => {
    setSortConfig((prev) => {
      if (prev?.key === key) {
        return { key, direction: prev.direction === "asc" ? "desc" : "asc" };
      }
      return { key, direction: "asc" };
    });
  };
  // const parseNullTerminatedString = (hexString) => {
  //   try {
  //     const buffer = new Uint8Array(
  //       hexString
  //         .slice(2) // Remove '0x' prefix
  //         .match(/.{1,2}/g) // Split into byte pairs
  //         .map((byte) => parseInt(byte, 16))
  //     );
  //     return new TextDecoder("utf-8").decode(buffer).split("\u0000")[0];
  //   } catch {
  //     return "-";
  //   }
  // };
  const sortedEntities = [...affixPrototypeEntities].sort((a, b) => {
    if (!sortConfig) return 0;
    const affixA = getComponentValueStrict(AffixPrototype, a);
    const affixB = getComponentValueStrict(AffixPrototype, b);
    const valueA = affixA[sortConfig.key] ?? "";
    const valueB = affixB[sortConfig.key] ?? "";

    if (valueA < valueB) return sortConfig.direction === "asc" ? -1 : 1;
    if (valueA > valueB) return sortConfig.direction === "asc" ? 1 : -1;
    return 0;
  });

  return (
    <section className="flex flex-col mx-5 md:mx-10">
      <h2 className="text-2xl text-dark-comment m-2">
        {"// Affix Prototypes"}
      </h2>
      <div className="overflow-x-auto">
        <table className="min-w-full border border-dark-control text-left text-dark-number">
          <thead className="bg-dark-background">
            <tr>
              <th className="p-2 border border-dark-control text-dark-keyword">
                Entity
              </th>
              <th
                className="p-2 border border-dark-control text-dark-keyword cursor-pointer"
                onClick={() => handleSort("name")}
              >
                Name{" "}
                {sortConfig?.key === "name"
                  ? sortConfig.direction === "asc"
                    ? "▲"
                    : "▼"
                  : ""}
              </th>
              <th
                className="p-2 border border-dark-control text-dark-keyword cursor-pointer"
                onClick={() => handleSort("affixTier")}
              >
                Affix Tier{" "}
                {sortConfig?.key === "affixTier"
                  ? sortConfig.direction === "asc"
                    ? "▲"
                    : "▼"
                  : ""}
              </th>
              <th
                className="p-2 border border-dark-control text-dark-keyword cursor-pointer"
                onClick={() => handleSort("exclusiveGroup")}
              >
                Exclusive Group{" "}
                {sortConfig?.key === "exclusiveGroup"
                  ? sortConfig.direction === "asc"
                    ? "▲"
                    : "▼"
                  : ""}
              </th>
            </tr>
          </thead>
          <tbody>
            {sortedEntities.map((entity) => {
              const affixProtoData = getComponentValueStrict(
                AffixPrototype,
                entity,
              );
              return (
                <tr key={entity} className="border border-dark-control">
                  <td className="p-2 border border-dark-control">
                    <span
                      className="hover:underline cursor-pointer"
                      onClick={() => navigator.clipboard.writeText(entity)}
                    >
                      {formatEntity(entity)}
                    </span>
                  </td>
                  <td className="p-2 border border-dark-control">
                    {affixProtoData.name}
                  </td>
                  <td className="p-2 border border-dark-control">
                    {affixProtoData.affixTier}
                  </td>
                  <td className="p-2 border border-dark-control">
                    <span
                      className="hover:underline cursor-pointer"
                      onClick={() =>
                        navigator.clipboard.writeText(
                          affixProtoData.exclusiveGroup,
                        )
                      }
                    >
                      {formatEntity(affixProtoData.exclusiveGroup)}
                    </span>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </section>
  );
};

export default AdminPanel;
