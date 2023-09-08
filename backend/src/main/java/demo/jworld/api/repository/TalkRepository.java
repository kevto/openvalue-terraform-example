package demo.jworld.api.repository;

import demo.jworld.api.model.Talk;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TalkRepository extends JpaRepository<Talk, Long> {
}
