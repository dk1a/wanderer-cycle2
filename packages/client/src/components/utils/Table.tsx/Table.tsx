import React from "react";

type Column = {
  key: string;
  label: string;
};

type Row = {
  [key: string]: React.ReactNode;
};

type TableProps = {
  columns: Column[];
  data: Row[];
  onSort: (key: string) => void;
};

export const Table: React.FC<TableProps> = ({ columns, data, onSort }) => {
  return (
    <table className="min-w-full border border-dark-control text-left text-dark-number">
      <thead className="bg-dark-background">
        <tr>
          {columns.map((column) => (
            <th
              key={column.key}
              className="p-2 border border-dark-control text-dark-keyword cursor-pointer"
              onClick={() => onSort(column.key)}
            >
              {column.label}
            </th>
          ))}
        </tr>
      </thead>
      <tbody>
        {data.map((row, rowIndex) => (
          <tr key={rowIndex} className="border border-dark-control">
            {columns.map((column) => (
              <td key={column.key} className="p-2 border border-dark-control">
                {row[column.key]}
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
};
