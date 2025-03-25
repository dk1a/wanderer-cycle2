import { Suspense } from "react";
import { Route, BrowserRouter as Router, Routes } from "react-router-dom";
import { Navbar } from "./components/Navbar/Navbar";
import AdminPanel from "./pages/AdminPanel/AdminPanel";
import { routeConfig } from "./pages/routeConfig/routeConfig";
import { GameRoot } from "./GameRoot";
import PrivateRoute from "./PrivateRoute";

export const App = () => {
  return (
    <Router>
      <div className="flex flex-col h-full">
        <Routes>
          <Route path="/admin"></Route>

          <Route
            path="/*"
            element={
              <Navbar className="bg-dark-400 border-dark-400 text-dark-300 md:p-6 p-4 flex items-center justify-start md:justify-center w-full" />
            }
          ></Route>
        </Routes>

        <div className="flex-1 overflow-y-auto ">
          <Routes>
            <Route path="/admin" element={<AdminPanel />}></Route>

            <Route path="/" element={<GameRoot />}>
              {Object.values(routeConfig)
                .filter((route) => !route.external)
                .map(({ element, path, isProtected }) => {
                  if (!element) return null;

                  return (
                    <Route
                      key={path}
                      path={path.replace("/", "")}
                      element={
                        <Suspense fallback="Loading...">
                          {isProtected ? (
                            <PrivateRoute>{element}</PrivateRoute>
                          ) : (
                            element
                          )}
                        </Suspense>
                      }
                    />
                  );
                })}
            </Route>
          </Routes>
        </div>
      </div>
    </Router>
  );
};
