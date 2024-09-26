interface NotFoundPageProps {
  className?: string;
}

const NotFoundPage = ({ className }: NotFoundPageProps) => {
  return <div className={classNames(cls.NotFoundPage, {}, [className])}></div>;
};

export default NotFoundPage;
