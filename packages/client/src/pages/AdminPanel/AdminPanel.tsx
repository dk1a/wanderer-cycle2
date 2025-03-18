import { useEntityQuery } from "@latticexyz/react";
import { getComponentValueStrict, Has } from "@latticexyz/recs";
import { Tooltip } from "react-tooltip";
import { useMUD } from "../../MUDContext";
import { formatEntity } from "../../mud/utils/sliceAddress";

const AdminPanel = () => {
  const { components } = useMUD();
  const {
    AffixPrototype,
    AffixNaming,
    // AffixPrototypeAvailable
  } = components;
  const affixPrototypeEntities = useEntityQuery([Has(AffixPrototype)]);
  const affixNamingEntities = useEntityQuery([Has(AffixNaming)]);
  // const affixPrototypeAvailableEntities = useEntityQuery([Has(AffixPrototypeAvailable)]);

  return (
    <section className="flex justify-center flex-col mx-5 md:mx-10">
      <div className="text-2xl text-dark-comment m-2">{"// affixes"}</div>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {affixPrototypeEntities.map((entity) => {
          const affixProtoData = getComponentValueStrict(
            AffixPrototype,
            entity,
          );
          return (
            <div
              key={entity}
              data-tooltip-id={entity}
              className="p-4 bg-dark-background border border-dark-control shadow-md text-center cursor-pointer"
            >
              <div className="text-dark-type">{affixProtoData.name}</div>

              <Tooltip
                id={entity}
                place="bottom"
                className="bg-dark-background p-4 border border-dark-control rounded-lg max-w-[300px] break-words"
                clickable
              >
                <table className="text-dark-control w-full">
                  <tbody>
                    <tr className="border-b border-dark-control">
                      <td className="pr-4 font-bold py-1">Entity:</td>
                      <td className="py-1">
                        <span
                          data-tooltip-id={`entity-full-${entity}`}
                          data-tooltip-content={entity}
                          className="hover:underline cursor-help"
                        >
                          {formatEntity(entity)}
                        </span>
                        <Tooltip id={`entity-full-${entity}`} />
                      </td>
                    </tr>
                    {Object.entries(affixProtoData).map(([key, value]) => (
                      <tr key={key} className="">
                        <td className="pr-4 font-bold py-1 text-dark-key">
                          {key}:
                        </td>
                        <td className="py-1 text-dark-number">
                          {typeof value === "string" && value.length > 20 ? (
                            <span
                              data-tooltip-id={`value-full-${entity}-${key}`}
                              data-tooltip-content={value}
                              className="hover:underline cursor-help"
                            >
                              {formatEntity(value)}
                            </span>
                          ) : (
                            JSON.stringify(value)
                          )}
                          <Tooltip id={`value-full-${entity}-${key}`} />
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </Tooltip>
            </div>
          );
        })}
      </div>

      <div className="text-2xl text-dark-comment m-2">{"// affixNames"}</div>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {affixNamingEntities.map((entity) => {
          const affixNamingData = getComponentValueStrict(AffixNaming, entity);
          console.log(affixNamingData);

          return (
            <div
              key={entity}
              data-tooltip-id={entity}
              className="p-4 bg-dark-background border border-dark-control shadow-md text-center cursor-pointer"
            >
              <div className="text-dark-type">{affixNamingData.label}</div>

              <Tooltip
                id={entity}
                place="bottom"
                className="bg-dark-background p-4 border border-dark-control rounded-lg max-w-[300px] break-words"
                clickable
              >
                <table className="text-dark-control w-full">
                  <tbody>
                    <tr className="border-b border-dark-control">
                      <td className="pr-4 font-bold py-1">Entity:</td>
                      <td className="py-1">
                        <span
                          data-tooltip-id={`entity-full-${entity}`}
                          data-tooltip-content={entity}
                          className="hover:underline cursor-help"
                        >
                          {formatEntity(entity)}
                        </span>
                        <Tooltip id={`entity-full-${entity}`} />
                      </td>
                    </tr>
                    {Object.entries(affixNamingData).map(([key, value]) => (
                      <tr key={key} className="">
                        <td className="pr-4 font-bold py-1 text-dark-key">
                          {key}:
                        </td>
                        <td className="py-1 text-dark-number">
                          {typeof value === "string" && value.length > 20 ? (
                            <span
                              data-tooltip-id={`value-full-${entity}-${key}`}
                              data-tooltip-content={value}
                              className="hover:underline cursor-help"
                            >
                              {formatEntity(value)}
                            </span>
                          ) : (
                            JSON.stringify(value)
                          )}
                          <Tooltip id={`value-full-${entity}-${key}`} />
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </Tooltip>
            </div>
          );
        })}
      </div>

      {/* <div className="text-2xl text-dark-comment m-2">{"// affixPrototypeAvailableEntitiesData"}</div>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {affixPrototypeAvailableEntities.map((entity) => {
          const affixPrototypeAvailableEntitiesData = getComponentValueStrict(
            AffixPrototypeAvailable,
            entity,
          );          
          
          return (
            <div
              key={entity}
              data-tooltip-id={entity}
              className="p-4 bg-dark-background border border-dark-control shadow-md text-center cursor-pointer"
            >
              {/* <div className="text-dark-type">{affixPrototypeAvailableEntitiesData.label}</div> */}

      {/* <Tooltip
                id={entity}
                place="bottom"
                className="bg-dark-background p-4 border border-dark-control rounded-lg max-w-[300px] break-words"
                clickable
              >
                <table className="text-dark-control w-full">
                  <tbody>
                    <tr className="border-b border-dark-control">
                      <td className="pr-4 font-bold py-1">Entity:</td>
                      <td className="py-1">
                        <span
                          data-tooltip-id={`entity-full-${entity}`}
                          data-tooltip-content={entity}
                          className="hover:underline cursor-help"
                        >
                          {formatEntity(entity)}
                        </span>
                        <Tooltip id={`entity-full-${entity}`} />
                      </td>
                    </tr>
                    {Object.entries(affixPrototypeAvailableEntitiesData).map(([key, value]) => (
                      <tr key={key} className="">
                        <td className="pr-4 font-bold py-1 text-dark-key">
                          {key}:
                        </td>
                        <td className="py-1 text-dark-number">
                          {typeof value === "string" && value.length > 20 ? (
                            <span
                              data-tooltip-id={`value-full-${entity}-${key}`}
                              data-tooltip-content={value}
                              className="hover:underline cursor-help"
                            >
                              {formatEntity(value)}
                            </span>
                          ) : (
                            JSON.stringify(value)
                          )}
                          <Tooltip id={`value-full-${entity}-${key}`} />
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </Tooltip>
            </div>
          );
        })}
      </div> */}
    </section>
  );
};

export default AdminPanel;
