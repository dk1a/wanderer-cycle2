import React, { Suspense } from "react";
import { Route, Routes } from "react-router-dom";
import { routeConfig } from "./pages/routeConfig/routeConfig";

const AppRouter = () => (
  <Routes>
    {Object.values(routeConfig).map(({ element, path }) => (
      <Route
        key={path}
        path={path}
        element={
          <Suspense fallback={"loading..."}>
            <div className="page-wrapper">{element}</div>
          </Suspense>
        }
      />
    ))}
  </Routes>
);

export default AppRouter;
