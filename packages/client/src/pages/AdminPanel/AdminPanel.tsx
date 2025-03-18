import { useMUD } from "../../MUDContext";

const AdminPanel = () => {
  const mud = useMUD();
  console.log(mud);
  const { components } = mud;
  console.log(components);

  return (
    <section className="flex  justify-center flex-col mx-5 md:mx-10">
      <div className="text-2xl text-dark-comment m-2">{"// affixes"}</div>
    </section>
  );
};

export default AdminPanel;
