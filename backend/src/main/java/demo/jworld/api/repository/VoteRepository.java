package demo.jworld.api.repository;

import demo.jworld.api.model.Talk;
import demo.jworld.api.model.Vote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VoteRepository extends JpaRepository<Vote, Long> {

    List<Vote> findByTalk(Talk talk);

}
