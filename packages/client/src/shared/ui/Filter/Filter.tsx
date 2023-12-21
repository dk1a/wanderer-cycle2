import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Filter.module.scss'
import Select from "react-select/base";
import Input from "@/shared/ui/Input/Input";

export const inventorySortOptions = [
  { value: "ilvl", label: "ilvl" },
  { value: "name", label: "name" },
] as const;

export type InventorySortOption = (typeof inventorySortOptions)[number] | null;

interface FilterProps{
  className?: string;
  sort: null;
  setSort: () => void;
  setFilter: () => void;
  filter: string;
}

const Filter = ({className, sort, setSort, filter, setFilter}: FilterProps) => {
  return (
    <div className={classNames(cls.Filter , {}, [className])}>
      <Select
        classNamePrefix={"custom-select"}
        placeholder={"select"}
        value={sort}
        onChange={setSort}
        options={inventorySortOptions}
      />
      <Input value={filter} onChange={(e) => setFilter(e.target.value)} placeholder={"Search..."} />
    </div>
  );
};

export default Filter;